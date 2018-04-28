Return-Path: virtio-dev-return-3996-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F2B35818E8A
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 17:36:12 -0700 (PDT)
References: <20180425082312.32244-1-tiwei.bie@intel.com>
 <09fbd602-96f4-9444-977a-979b234cbcdb@redhat.com>
 <20180425172658-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <857fa139-3245-f13f-5b69-3433d4a8e661@redhat.com>
Date: Sat, 28 Apr 2018 02:35:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180425172658-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC] VIRTIO_F_IO_BARRIER: use I/O barriers in driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, stefanha@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 25/04/2018 16:29, Michael S. Tsirkin wrote:
>> Unfortunately this doesn't work as mentioned earlier.  Virtio live
>> migration assumes that features are safe if you have them on the
>> destination but not on the source; this feature however works the
>> opposite way.
>
> That's a qemu code property, and it's because it does not
> migrate host properties right now. When implementing this feature we
> can add migration of host features.

You don't even need to migrate host features; it's just that guest
feature negotiation is repeated on the destination, and live migration
reports an error if the negotiation fails.  The guest feature
negotiation is complicated a little bit by this feature, but I guess it
can work...

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

