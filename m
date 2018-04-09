Return-Path: virtio-return-3053-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523300322-21989-5-git-send-email-pasic@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79445753-5c65-3ffb-f84d-578a50037561@redhat.com>
Date: Mon, 9 Apr 2018 21:51:06 +0200
MIME-Version: 1.0
In-Reply-To: <1523300322-21989-5-git-send-email-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH 4/5] packed-ring: reposition drivernormative on
 driver notifications
To: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 09/04/2018 20:58, Halil Pasic wrote:
>  The driver has to be careful to expose the new \field{flags}
>  value before checking if notifications are suppressed.

This paragraph should also be reworked to be part of the normative text
below, I think?  The memory barrier must be "between two things", and
only with this paragraph you know that it's between the flags write and
the suppression structure read.

Thanks,

Paolo

> +\drivernormative{\paragraph}{Notifying The Device}{Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
> +The driver MUST perform a suitable memory barrier before reading
> +the Driver Event Suppression structure, to avoid missing a notification.
> +


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

