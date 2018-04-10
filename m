Return-Path: virtio-return-3057-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523300322-21989-5-git-send-email-pasic@linux.vnet.ibm.com>
 <79445753-5c65-3ffb-f84d-578a50037561@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 12:25:14 +0200
MIME-Version: 1.0
In-Reply-To: <79445753-5c65-3ffb-f84d-578a50037561@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e5e2df6e-59cf-9a97-861c-53b0e5160a79@linux.vnet.ibm.com>
Subject: Re: [virtio] [PATCH 4/5] packed-ring: reposition drivernormative on
 driver notifications
To: Paolo Bonzini <pbonzini@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 04/09/2018 09:51 PM, Paolo Bonzini wrote:
> On 09/04/2018 20:58, Halil Pasic wrote:
>>  The driver has to be careful to expose the new \field{flags}
>>  value before checking if notifications are suppressed.
> 
> This paragraph should also be reworked to be part of the normative text
> below, I think?  The memory barrier must be "between two things", and
> only with this paragraph you know that it's between the flags write and
> the suppression structure read.
> 
All I did was to move the device normative to a better place. IMHO
it's current place is obviously wrong. So, I read your comment as
there should be a patch on top that further integrates the paragraphs
made adjacent by this patch. Is that right?

About the normative statements. I hinted before that I don't really
understand the role of normative statements in this specification. To
be more precise, my naive understanding of their role is in conflict
with the reality of the specification.

Can someone tell me what is supposed to go in a normative statements
and what is supposed to go outside? Along with an estimate how good
are we at adhering to those rules.

Regards,
Halil

> 
>> +\drivernormative{\paragraph}{Notifying The Device}{Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
>> +The driver MUST perform a suitable memory barrier before reading
>> +the Driver Event Suppression structure, to avoid missing a notification.
>> +
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe from this mail list, you must leave the OASIS TC that 
> generates this mail.  Follow this link to all your TCs in OASIS at:
> https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
> 


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

