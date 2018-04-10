Return-Path: virtio-return-3058-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523300322-21989-5-git-send-email-pasic@linux.vnet.ibm.com>
 <79445753-5c65-3ffb-f84d-578a50037561@redhat.com>
 <e5e2df6e-59cf-9a97-861c-53b0e5160a79@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b0c61bd-d2f9-3bdb-32de-789e65a5a703@redhat.com>
Date: Tue, 10 Apr 2018 13:05:29 +0200
MIME-Version: 1.0
In-Reply-To: <e5e2df6e-59cf-9a97-861c-53b0e5160a79@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH 4/5] packed-ring: reposition drivernormative on
 driver notifications
To: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 10/04/2018 12:25, Halil Pasic wrote:
> All I did was to move the device normative to a better place. IMHO
> it's current place is obviously wrong.

I agree with that - but IMO you're now separating two related paragraphs.

> So, I read your comment as
> there should be a patch on top that further integrates the paragraphs
> made adjacent by this patch. Is that right?

It can even be the same patch, reworked to put something like this in
the normative text:

The driver MUST ensure the write to the \field{flags} field is performed
before the read of the Driver Event Suppression, in order to avoid
missing a notification from the device.

> About the normative statements. I hinted before that I don't really
> understand the role of normative statements in this specification. To
> be more precise, my naive understanding of their role is in conflict
> with the reality of the specification.
> 
> Can someone tell me what is supposed to go in a normative statements
> and what is supposed to go outside? Along with an estimate how good
> are we at adhering to those rules.

Anything that is declared "MUST", "SHOULD" or "MAY" constitutes a
normative statement.

Paolo

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

