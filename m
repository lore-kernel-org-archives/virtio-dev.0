Return-Path: virtio-dev-return-4731-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9869A985C7A
	for <virtio-dev@lists.oasis-open.org>; Tue, 24 Jul 2018 01:45:10 +0000 (UTC)
Message-ID: <5B5685A0.9040005@intel.com>
Date: Tue, 24 Jul 2018 09:49:20 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com> <1532075585-39067-3-git-send-email-wei.w.wang@intel.com> <20180722174125-mutt-send-email-mst@kernel.org> <5B55AE56.5030404@intel.com> <20180723170826-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180723170826-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v36 2/5] virtio_balloon: replace oom notifier with shrinker
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/23/2018 10:13 PM, Michael S. Tsirkin wrote:
>>>    	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>>>    #endif
>>> +	err = virtio_balloon_register_shrinker(vb);
>>> +	if (err)
>>> +		goto out_del_vqs;
>>> So we can get scans before device is ready. Leak will fail
>>> then. Why not register later after device is ready?
>> Probably no.
>>
>> - it would be better not to set device ready when register_shrinker failed.
> That's very rare so I won't be too worried.

Just a little confused with the point here. "very rare" means it still 
could happen (even it's a corner case), and if that happens, we got 
something wrong functionally. So it will be a bug if we change like 
that, right?

Still couldn't understand the reason of changing shrinker_register after 
device_ready (the original oom notifier was registered before setting 
device ready too)?
(I think the driver won't get shrinker_scan called if device isn't ready 
because of the reasons below)

>> - When the device isn't ready, ballooning won't happen, that is,
>> vb->num_pages will be 0, which results in shrinker_count=0 and shrinker_scan
>> won't be called.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

