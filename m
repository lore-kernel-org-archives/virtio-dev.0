Return-Path: virtio-dev-return-2998-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CCD5C1CB8080
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jan 2018 22:21:56 -0800 (PST)
Message-ID: <5A618F0B.4090805@intel.com>
Date: Fri, 19 Jan 2018 14:24:11 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1516165812-3995-1-git-send-email-wei.w.wang@intel.com> <1516165812-3995-3-git-send-email-wei.w.wang@intel.com> <20180117180337-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180117180337-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v22 2/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/18/2018 12:44 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 17, 2018 at 01:10:11PM +0800, Wei Wang wrote:
>>   
>> +static void virtballoon_changed(struct virtio_device *vdev)
>> +{
>> +	struct virtio_balloon *vb = vdev->priv;
>> +	unsigned long flags;
>> +	__u32 cmd_id;
>> +	s64 diff = towards_target(vb);
>> +
>> +	if (diff) {
>> +		spin_lock_irqsave(&vb->stop_update_lock, flags);
>> +		if (!vb->stop_update)
> Why do you ignore stop_update for freeze?
> This means new wq entries can be added during remove
> causing use after free issues.

I think stop_update isn't needed, because the lock has already been 
handled internally by the APIs. Similar examples like 
mem_cgroup_css_free() in "mm/memcontrol.c", there is no such locks used 
for cancel_work_sync(&memcg->high_work).

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

