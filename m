Return-Path: virtio-return-3169-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
 <20180703030130-mutt-send-email-mst@kernel.org>
 <2cbc368b-de0c-563e-3524-7f54bfe37d1e@linux.ibm.com>
 <71c9fa95-b672-e51e-cc5a-a754fe033ee9@linux.ibm.com>
 <a785ef89-ae5d-abe0-4650-9706d5630e8e@linux.ibm.com>
 <477abdb8-93c4-5ff6-17b2-0f3ed1a829a4@linux.ibm.com>
 <20180727143700-mutt-send-email-mst@kernel.org>
 <38436869-1a5e-9d17-a1fb-a6049f0f8bd5@linux.ibm.com>
 <20180802012748-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 2 Aug 2018 19:12:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180802012748-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <96b4f75b-fb11-9c4f-12db-402021c96c03@linux.ibm.com>
Subject: Re: [virtio] Re: [virtio-dev] Re: [virtio] Re: [virtio-dev] [PATCH v3
 0/6] rework notifications terminology
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 08/02/2018 12:30 AM, Michael S. Tsirkin wrote:
> On Wed, Aug 01, 2018 at 03:04:54PM +0200, Halil Pasic wrote:
>>
>>
>> On 07/27/2018 01:45 PM, Michael S. Tsirkin wrote:
>>> On Fri, Jul 27, 2018 at 01:33:15PM +0200, Halil Pasic wrote:
>>>>
>>>>
>>>> On 07/17/2018 06:47 PM, Halil Pasic wrote:
>>>>>>>>
>>>>>>>> OK I see there are acks already - do you want to start voting on this?
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> Yes, voting would make sense in my opinion.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> I've submitted a github issue. Please let me know if further actions are
>>>>>> required.
>>>>>>
>>>>>
>>>>> ping
>>>>
>>>> ping
>>>
>>> Oh, sorry, I wasn't clear.
>>> What you want to do is
>>> 1. post the patches including
>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/16
>>> in the commit log part.
>>> 2. proposal must link to oasis archive, not mail-archive.
>>>
>>> Anyway, I fixed the link and started voting now.
>>>
>>
>> Should post a v4 (or a 'REPOST v3') with the r-b's received for
>> v3 and the 'Fixes' tags? I mean the ballot, would not link to the
>> final thread then. I'm a bit confused regarding now, but I
>> think I understood the process.
> 
> I think you are right since ballot started no need for v4.
> 

Thanks!

>> FYI I'm on and off starting tomorrow till 5th September. I
>> am very likely to make any ballots though, but longer response
>> times and lower availability are to be expected.
>>
>> Thanks,
>> Halil
> 
> What are we going to do about crypto proposals? I think we do want to
> finalize a draft for public review by september, and it seems
> very unfortunate not to have that device in the draft at all.
> 

As I wrote in the other thread I'm fine either way. But I don't
think I will be able to muster the time and go trough he spec
and the code by September. I have a couple of weeks of vacation
in August, but I intend to stay tuned.

Given the whole situation, I have the feeling merging the thing
even if it's a bit 'on risk' seems to be the most reasonable option.
I often tend to regard standards as 'holy cow that is cast in
stone'. That makes me over-cautious. If something needs to be
fixed, we can fix it when the need becomes apparent.

Best regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

