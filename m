Return-Path: virtio-dev-return-6963-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D318985D3B
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Mar 2020 11:17:41 +0000 (UTC)
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org>
 <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org>
 <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
 <20200310021729-mutt-send-email-mst@kernel.org>
 <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
 <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f43a280-5425-3a10-1312-22ea87d320ca@redhat.com>
Date: Thu, 19 Mar 2020 12:17:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Rob Miller <rob.miller@broadcom.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

The sentence below refers to emulated device DMA.

When emulated devices inside QEMU perform DMA goes through functions
that keep the dirty page bitmap up to date.  Likewise for CPU emulation
performed by QEMU, which is not an issue if you are using KVM or other
hypervisors supported by QEMU.

Whenever external code touches memory (which includes all the cases
mentioned by Jason), it has to provide an interface for QEMU to read the
dirty page bitmaps and synchronize them at appropriate points.

Paolo

On 18/03/20 16:13, Rob Miller wrote:
> In trying to more fully understand DPT, I ran across an article
> regarding how Physical RAM works within QEMU and noticed the statement
> below. My current understanding, based upon the statement, is that DPT
> is automatic inside QEMU. I can understand that this scheme=C2=A0is not
> employed=C2=A0in all hypervisors, but i'm wondering if others, b/c of VM
> migration, do have a similar=C2=A0scheme.
>=20
>=20
>     Dirty memory tracking
>=20
> When the guest CPU or device DMA stores to guest RAM this needs to be
> noticed by several users:
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

