Return-Path: virtio-dev-return-6009-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC617985CA6
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Aug 2019 16:19:14 +0000 (UTC)
References: <20190821145806.20926.22448.stgit@localhost.localdomain>
 <20190821145950.20926.83684.stgit@localhost.localdomain>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <91355107-ed73-fce5-7051-3a746b526163@redhat.com>
Date: Thu, 22 Aug 2019 12:18:56 -0400
MIME-Version: 1.0
In-Reply-To: <20190821145950.20926.83684.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v6 4/6] mm: Introduce Reported pages
To: Alexander Duyck <alexander.duyck@gmail.com>, kvm@vger.kernel.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, virtio-dev@lists.oasis-open.org, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, riel@surriel.com, konrad.wilk@oracle.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/21/19 10:59 AM, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> In order to pave the way for free page reporting in virtualized
> environments we will need a way to get pages out of the free lists and
> identify those pages after they have been returned. To accomplish this,=

> this patch adds the concept of a Reported Buddy, which is essentially
> meant to just be the Uptodate flag used in conjunction with the Buddy
> page type.
>
> It adds a set of pointers we shall call "boundary" which represents the=

> upper boundary between the unreported and reported pages. The general i=
dea
> is that in order for a page to cross from one side of the boundary to t=
he
> other it will need to go through the reporting process. Ultimately a
> free_list has been fully processed when the boundary has been moved fro=
m
> the tail all they way up to occupying the first entry in the list.
>
> Doing this we should be able to make certain that we keep the reported
> pages as one contiguous block in each free list. This will allow us to
> efficiently manipulate the free lists whenever we need to go in and sta=
rt
> sending reports to the hypervisor that there are new pages that have be=
en
> freed and are no longer in use.
>
> An added advantage to this approach is that we should be reducing the
> overall memory footprint of the guest as it will be more likely to recy=
cle
> warm pages versus trying to allocate the reported pages that were likel=
y
> evicted from the guest memory.
>
> Since we will only be reporting one zone at a time we keep the boundary=

> limited to being defined for just the zone we are currently reporting p=
ages
> from. Doing this we can keep the number of additional pointers needed q=
uite
> small. To flag that the boundaries are in place we use a single bit
> in the zone to indicate that reporting and the boundaries are active.
>
> The determination of when to start reporting is based on the tracking o=
f
> the number of free pages in a given area versus the number of reported
> pages in that area. We keep track of the number of reported pages per
> free_area in a separate zone specific area. We do this to avoid modifyi=
ng
> the free_area structure as this can lead to false sharing for the highe=
st
> order with the zone lock which leads to a noticeable performance
> degradation.
[...]
> +
> +/* request page reporting on this zone */
> +void __page_reporting_request(struct zone *zone)
> +{
> +	struct page_reporting_dev_info *phdev;
> +
> +	rcu_read_lock();
> +
> +	/*
> +	 * We use RCU to protect the ph_dev_info pointer. In almost all
> +	 * cases this should be present, however in the unlikely case of
> +	 * a shutdown this will be NULL and we should exit.
> +	 */
> +	phdev =3D rcu_dereference(ph_dev_info);
> +	if (unlikely(!phdev))
> +		return;
> +

Just a minor comment here.
Although this is unlikely to trigger still I think you should release the=

rcu_read_lock before returning.

> +	/*
> +	 * We can use separate test and set operations here as there
> +	 * is nothing else that can set or clear this bit while we are
> +	 * holding the zone lock. The advantage to doing it this way is
> +	 * that we don't have to dirty the cacheline unless we are
> +	 * changing the value.
> +	 */
> +	__set_bit(ZONE_PAGE_REPORTING_REQUESTED, &zone->flags);
> +
> +	/*
> +	 * Delay the start of work to allow a sizable queue to
> +	 * build. For now we are limiting this to running no more
> +	 * than 10 times per second.
> +	 */
> +	if (!atomic_fetch_inc(&phdev->refcnt))
> +		schedule_delayed_work(&phdev->work, HZ / 10);
> +
> +	rcu_read_unlock();
> +}
> +
[...]
> +	}
> +
> +	/* enable page reporting notification */
> +	static_branch_enable(&page_reporting_notify_enabled);
> +err_out:
> +	mutex_unlock(&page_reporting_mutex);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(page_reporting_startup);
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

