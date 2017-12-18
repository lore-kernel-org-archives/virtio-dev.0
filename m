Return-Path: virtio-dev-return-2851-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7388E5818F3C
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Dec 2017 07:28:03 -0800 (PST)
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
 <1512545840-10256-2-git-send-email-longpeng2@huawei.com>
 <0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
 <5A2E8067.4050000@huawei.com>
 <2b7048c1-e2f8-ab40-c4df-afe5efd8f95d@linux.vnet.ibm.com>
 <5A377F94.5000504@huawei.com>
 <968106e0-b839-22fc-e3ce-605b4e58fc97@linux.vnet.ibm.com>
 <20171218153450-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 16:27:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171218153450-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <0cada9eb-60c1-4b71-09a9-fef7db2c4831@linux.vnet.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [virtio-dev] Re: [v22 1/2] virtio-crypto: Add virtio
 crypto device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, xin.zeng@intel.com, jasowang@redhat.com, luonengjun@huawei.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, jianjay.zhou@huawei.com, Cornelia Huck <cohuck@redhat.com>, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 12/18/2017 02:51 PM, Michael S. Tsirkin wrote:
> On Mon, Dec 18, 2017 at 01:29:50PM +0100, Halil Pasic wrote:
[..]
>>
>> It isn't a big structural thing, but inconsistent wording can make
>> difficult to understand stuff even more difficult to understand.
>>
>> This wording stuff is not a show-stopper for me.
> 
> Right. There's a working implementation upstream that people use,
> so at this point we really need a description of that upstream,
> and add wording tweaks on top. And it's too late to change the
> interface drastically, any change must be compatible using
> feature bits for anything we want changed.
> 
> 

I fully agree. Please bear with me if end up complaining about
minor stuff identified while reviewing the spec and cross check
it with the implementation to make sure there is nothing major wrong.

[..]
>>>> * I assume one request is supposed to correspond to one descriptor chain.
>>>> Right? If yes, could you tell me, where is this expressed in the spec.
>>>>
>>
>> You have ignored this one. Michael said it's the default for the whole
>> spec, but I still don't know where is this requirement to be found
>> in the spec.
> 
> I was surprised to find this does not say this explicitly anywhere.
> I this we should add something like the below to the Virtqueues
> chapter:
> 
> 	Driver makes requests available to device by adding an available buffer
> 	to the queue - i.e. adding a buffer describing the request to a
> 	virtqueue, and optionally triggering a driver event - i.e. sending a
> 	notification to the device.  Device executes the requests and - when
> 	complete - adds a used buffer to the queue - i.e. lets the driver know
> 	by marking the buffer as used. Device can then trigger a device event -
> 	i.e. send an interrupt to the driver.

Thanks for verifying this. I can spin a patch addressing the issue, if you like.

If I'm going to do the patch, I would like take your text as a starting
point of (with your kind permission), but I would rather see this as belonging
to "3.2 Device Operation". (It's not about how virtqueues work, but how
virtio devices use virtqueues to do their thing.)

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

