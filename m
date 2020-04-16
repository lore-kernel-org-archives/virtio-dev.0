Return-Path: virtio-dev-return-7093-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F4FB986076
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Apr 2020 23:52:54 +0000 (UTC)
MIME-Version: 1.0
References: <20200416192809.8763.19308.stgit@localhost.localdomain> <20200416180845-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200416180845-mutt-send-email-mst@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 16 Apr 2020 16:52:42 -0700
Message-ID: <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 16, 2020 at 3:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 16, 2020 at 12:30:38PM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > If we have free page hinting or page reporting enabled we should disabl=
e it
> > if the pages are poisoned or initialized on free and we cannot notify t=
he
> > hypervisor.
> >
> > Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free pa=
ge reports to host")
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
>
> Why not put this logic in the hypervisor?

I did that too. This is to cover the case where somebody is running
the code prior to my QEMU changes where the page poison feature wasn't
being enabled.

> We don't know what hypervisor uses the hints for.

I agree, but at the same time the way the feature was originally coded
it was only checked if the FREE_PAGE_HINT feature was enabled. The
assumption there is that if we have page poison data and want to use
hints we need to report it. In my mind if we ever want to switch over
to the page reporting style setup for page hinting in the future we
will need to have it behave in a sane manner. So disabling it if we
have a poison value we need to report, but have no mechanism to report
it makes sense to me.

The actual likelihood of us encountering this case should be pretty
low anyway since it is not that common to have page poisoning or
init_on_free enabled.

> Yes you can not just drop them but you can maybe do
> other things such as MADV_SOFT_OFFLINE.
>
> Finally, VIRTIO_BALLOON_F_FREE_PAGE_HINT does nothing
> at all unless guest gets the command from hypervisor,
> so there isn't even any overhead.

The problem is we cannot communicate the full situation to the
hypervisor without the page poison feature being present. As such I
would worry about that backfiring on us due to the hypervisor acting
on incomplete data.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

