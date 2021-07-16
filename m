Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YO/8/LaHihUE1bhN@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <db6540cc-55f0-ec66-447a-4d70dcdc97bd@redhat.com>
Date: Fri, 16 Jul 2021 09:44:26 +0800
MIME-Version: 1.0
In-Reply-To: <YO/8/LaHihUE1bhN@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/15 下午5:16, Stefan Hajnoczi 写道:
> On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
>> 在 2021/7/14 下午11:07, Stefan Hajnoczi 写道:
>>> On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
>>>> And as I've stated several times, virtqueue is the interface or transport
>>>> which carries the commands for implementing specific semantics. It doesn't
>>>> conflict with what is proposed in this patch.
>>> The abstract operations for stopping the device and fetching virtqueue
>>> state sound good to me, but I don't think a Device Status field STOP bit
>>> should be added. An out-of-band stop operation would support devices
>>> that take a long time to stop better.
>>
>> So the long time request is not something that is introduced by the STOP
>> bit. Spec already use that for reset.
> Reset doesn't affect migration downtime. The register polling approach
> is problematic during migration downtime because it's difficult to stop
> multiple devices and do other downtime cleanup concurrently.


This part I don't understand. We don't have an centralized control path 
that is used for each virtual functions.

VMM is free to stop multiple devices and poll for all those device status?


> Stopping
> devices sequentially increases migration downtime, so I think the
> interface should encourage concurrently stopping multiple devices.
>
> I think you and Cornelia discussed that an interrupt could be added to
> solve this problem. That would address my concerns about the STOP bit.


The problems are:

1) if we generate an interrupt after STOP, it breaks the STOP semantic 
where the device should not generate any interrupt
2) if we generate an interrupt before STOP, we may end up with race 
conditions

Thanks


>
> Stefan

