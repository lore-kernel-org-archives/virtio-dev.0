Return-Path: virtio-return-3087-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523300322-21989-5-git-send-email-pasic@linux.vnet.ibm.com>
 <79445753-5c65-3ffb-f84d-578a50037561@redhat.com>
 <e5e2df6e-59cf-9a97-861c-53b0e5160a79@linux.vnet.ibm.com>
 <2b0c61bd-d2f9-3bdb-32de-789e65a5a703@redhat.com>
 <29af1c28-c7b0-a461-3c53-9b029512c6d7@linux.vnet.ibm.com>
 <20180420184651-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 20 Apr 2018 18:22:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180420184651-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b3946831-bdb2-b1c4-5c47-b917363b0893@linux.ibm.com>
Subject: Re: [virtio] [PATCH 4/5] packed-ring: reposition drivernormative on
 driver notifications
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 04/20/2018 05:59 PM, Michael S. Tsirkin wrote:
> On Tue, Apr 10, 2018 at 04:59:12PM +0200, Halil Pasic wrote:
>> My concern (regarding the whole spec) is the completeness and self
>> the containment of it's normative portion -- I'm not sure if either is
>> pursued rigorously.
> 
> No it isn't, and the reason is we do not want to bring the development
> to a complete halt :). Our charter is
> 
> 	Enhancing the performance of virtual devices by standardizing key
> 	features of the VIRTIO (Virtual I/O) Device Specification
> 
> Our job is thus to facilitate development by standardizing where it's
> helpful.
> 
> If we start asking people to write out a formal spec for any tiny
> change before they can release code, development will stop and
> performance will suffer.
> 
> And it's a balance: it should be clear what is going on,
> and if people can write it rigorously without confusing
> matters, it is helpful.
> 
> But we don't want something like e.g. the C or C++ language spec,
> where you can read all of it and still have no idea how to use it.
> 

I understand.

>> For instance take 'Supplying Buffers to The
>> Device' either for split or for packed. The algorithms described
>> there aren't constituting a normative section. Do you think these
>> can be inferred from the normative sections?
> 
> No but it's ok for normative sections to refer to the non-normative
> ones.
> 

Was, kind of, the point I tried to make. I've (for myself) given up on
these ideals. That's why I did not bother to think about isn't that sentence
normative section material. And I don't intend to clean up normative
vs non-normative.

Anyway, it is good to have it spelled out what is the objective of this document,
and what is not. I will continue to try to improve the specification,
in accordance to that -- and avoid hanging myself up on what is not
considered a primary objective.

Many thanks!

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

