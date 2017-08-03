Return-Path: virtio-dev-return-2442-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BD2D5818C68
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Aug 2017 05:25:30 -0700 (PDT)
Message-ID: <598316DB.4050308@intel.com>
Date: Thu, 03 Aug 2017 20:28:11 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com> <1501742299-4369-6-git-send-email-wei.w.wang@intel.com> <147332060.38438527.1501748021126.JavaMail.zimbra@redhat.com>
In-Reply-To: <147332060.38438527.1501748021126.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v13 5/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, mawilcox@microsoft.com, akpm@linux-foundation.org, virtio-dev@lists.oasis-open.org, david@redhat.com, cornelia huck <cornelia.huck@de.ibm.com>, mgorman@techsingularity.net, aarcange@redhat.com, amit shah <amit.shah@redhat.com>, pbonzini@redhat.com, liliang opensource <liliang.opensource@gmail.com>, yang zhang wz <yang.zhang.wz@gmail.com>, quan xu <quan.xu@aliyun.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 08/03/2017 04:13 PM, Pankaj Gupta wrote:
>>
>> +        /* Allocate space for find_vqs parameters */
>> +        vqs = kcalloc(nvqs, sizeof(*vqs), GFP_KERNEL);
>> +        if (!vqs)
>> +                goto err_vq;
>> +        callbacks = kmalloc_array(nvqs, sizeof(*callbacks), GFP_KERNEL);
>> +        if (!callbacks)
>> +                goto err_callback;
>> +        names = kmalloc_array(nvqs, sizeof(*names), GFP_KERNEL);
>                      
>         is size here (integer) intentional?


Sorry, I didn't get it. Could you please elaborate more?


>
>> +        if (!names)
>> +                goto err_names;
>> +
>> +        callbacks[0] = balloon_ack;
>> +        names[0] = "inflate";
>> +        callbacks[1] = balloon_ack;
>> +        names[1] = "deflate";
>> +
>> +        i = 2;
>> +        if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>> +                callbacks[i] = stats_request;
> just thinking if memory for callbacks[3] & names[3] is allocated?


Yes, the above kmalloc_array allocated them.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

