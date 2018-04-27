Return-Path: virtio-return-3097-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.ibm.com>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
 <6b8b5a58-3440-0974-3de2-10046fb13f8c@linux.ibm.com>
Date: Fri, 27 Apr 2018 18:07:51 +0200
MIME-Version: 1.0
In-Reply-To: <6b8b5a58-3440-0974-3de2-10046fb13f8c@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <2caf27b9-7a40-9c6d-9b68-8b0df0a30363@linux.ibm.com>
Subject: Re: [virtio] [PATCH 0/5] fixes and tweaks for virtio v1.1
To: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


I've decided not send a v1 until the fate of the notifications
series gets deiced (so I can hopefully base these on those). So,
some more time for comments.

Regards,
Halil


On 04/20/2018 05:00 PM, Halil Pasic wrote:
> ping
> 
> Some of the patches received feedback suggesting changes are to
> be pursued. Some patches did not receive any.
> 
> I would prefer having at least a 'the right direction'/'seems wrong' type
> of feedback for each patch before sending a non RFC with the requests
> made here addressed.
> 
> On 04/09/2018 08:58 PM, Halil Pasic wrote:
>> Some of these are more and some are less important. Please
>> be careful, there is always a chance that I misunderstood something
>> and that I'm trying to change for the worse.
>>
>> I've identified some other weak point's too, but tried to
>> proceed in order the more grave and the better I think I
>> understand it (and thus propose a fix) the higher the priority.
>>
>> Some stuff I've left for my notifiers patch set. This one
>> and that one will have to get merged if both turn out to
>> be good.
>>
>> Halil Pasic (5):
>>    packed-ring: fix used descriptors but meant buffers
>>    consistency: clean up stale  wording for v1.1 terms
>>    packed-packed: fix supplying buffers description
>>    packed-ring: reposition drivernormative on driver notifications
>>    packed-ring: tweak driver code example
>>
>>   content.tex     |   14 ++++----
>>   packed-ring.tex |   96 +++++++++++++++++++++++++++++-------------------------
>>   2 files changed, 59 insertions(+), 51 deletions(-) 


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

