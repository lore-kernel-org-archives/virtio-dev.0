Return-Path: virtio-dev-return-7041-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C524985FDB
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Apr 2020 02:40:13 +0000 (UTC)
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org>
 <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org>
 <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
 <20200310021729-mutt-send-email-mst@kernel.org>
 <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
 <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com>
 <0f43a280-5425-3a10-1312-22ea87d320ca@redhat.com>
 <CAJaqyWfeSgj=+RMM_Zy4gTAkNJ42Ax5Axvc8okHOhH7UTsxhaA@mail.gmail.com>
 <20200409170152-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cf4a59a4-ee86-1d9e-147e-e30e586e2320@redhat.com>
Date: Fri, 10 Apr 2020 10:40:00 +0800
MIME-Version: 1.0
In-Reply-To: <20200409170152-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>
Cc: Rob Miller <rob.miller@broadcom.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/4/10 =E4=B8=8A=E5=8D=885:06, Michael S. Tsirkin wrote:
> On Tue, Apr 07, 2020 at 11:52:46AM +0200, Eugenio Perez Martin wrote:
>> Hi!
>>
>> So, from the previous mails, it seems that monitoring the used ring
>> (and the packed descriptors) is a good first step in that direction,
>> as DPDK did. This way, the device does not need to worry about the
>> dirty page tracking using a bitmap and the PCI writes limitation, and
>> we can evaluate later the proposed alternatives:
>> * Alternate used descriptors in packed.
>> * vDPA interface for vDPA devices in a convenient format.
>>
>> Any thoughts? Do you think that we should start with another way?
>>
>> Thanks!
> I am concerned that with software in data path, we'll hit RX queue
> underruns, won't we?


Do you mean it will lose some performance? If yes, I think so.


> Two ways to avoid underruns:
> - dirty page tracking
> - page faults


It looks to me this will lead even worse performance than software path?=20
There will be lots of page faults during RX.

Another direction is to track dirty pages via IOMMU. E.g recent Intel=20
IOMMU has EA and D bit which could be used for tracking pages wrote by=20
devices but not CPU.


>
> I'm working on a proposal for page faults now.


I guess it's better to have a transport independent method.


> If someone wants
> to work on dirty tracking in addition, that's also an option.


I remember Rob mention some challenges of implementing dirty bitmap, I=20
wonder something like queue based interface would be better (similar to=20
Peter did for KVM)?

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

