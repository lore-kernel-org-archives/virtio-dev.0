Return-Path: virtio-return-3070-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523398287-25480-2-git-send-email-pasic@linux.vnet.ibm.com>
 <20180411021955.GG28698@stefanha-x1.localdomain>
 <58fe7c8a-0d5a-609c-9ee9-2421eae8b649@redhat.com>
 <20180411145545.044a11f9.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58e8eeb1-5406-d930-f456-842cfef26103@redhat.com>
Date: Wed, 11 Apr 2018 15:11:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180411145545.044a11f9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [RFC PATCH 1/3] notifications: unify
 notifications wording in core
To: Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/04/2018 14:55, Cornelia Huck wrote:
>>> Nice, I think the cleanup is worthwhile.  
>> I agree.  I wondered if we should use the term "used buffer interrupt"
>> and "available buffer notification".  In the common case I think it
>> would be clearer, though there are cases such as vhost-pci where the
>> roles are swapped.
>
> If it is swapped in some cases, it is bound to cause confusion for
> those. I'd vote for using "notification" in both cases, as this patch
> is doing.

Fair enough!  I think I agree myself. :)

Paolo

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

