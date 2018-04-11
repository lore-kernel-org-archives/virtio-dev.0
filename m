Return-Path: virtio-return-3066-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523398287-25480-2-git-send-email-pasic@linux.vnet.ibm.com>
 <20180411021955.GG28698@stefanha-x1.localdomain>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2018 12:58:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180411021955.GG28698@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <360d1dd8-f8a3-a7bc-c75f-fcae7a3fb729@linux.vnet.ibm.com>
Subject: Re: [virtio] [RFC PATCH 1/3] notifications: unify notifications
 wording in core
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 04/11/2018 04:19 AM, Stefan Hajnoczi wrote:
> On Wed, Apr 11, 2018 at 12:11:25AM +0200, Halil Pasic wrote:
>> Let us unify the wording when talking about notifications. This change
>> establishes the terms available buffer notification for what was usually
>> simply called notification or virtqueue notification in v1.0 and used
>> buffer notification for what was usually called interrupt.
>>
>> The term configuration change notification in kept where called so and
>> consolidated where it's called configuration change interrupt or
>> similar.
>>
>> The changes done here are limited to the core part, and don't
>> conceptually involve neither the transports nor the devices (references
>> are updated though). Future changes should address these parts.
> 
> Nice, I think the cleanup is worthwhile.
> 

Thanks!

>>  \begin{lstlisting}
>> -virtq_disable_interrupts(vq);
>> +virtq_disable_notifications(vq);
> 
> This name is ambiguous.  Only used buffer notifications are disabled,
> not configuration change notifications.
>

One could argue that the only virtqueue scoped notification received
by the driver are used buffer notifications. That's why I thought
this would be sufficient (btw. if it's ambiguous it was ambiguous before
too as both options are called interrupts).

But the more straight-forward the better.
 
> How about:
> 
>   virtq_disable_used_buffer_notifications(vq);
> 

In absence of further discussion I will take this for the next
version.

Thanks again!

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

