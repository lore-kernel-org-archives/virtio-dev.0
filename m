Return-Path: virtio-dev-return-6640-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86374985E4D
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Jan 2020 16:47:38 +0000 (UTC)
Date: Thu, 9 Jan 2020 11:47:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200109114209-mutt-send-email-mst@kernel.org>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
 <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
 <20200105054142-mutt-send-email-mst@kernel.org>
 <02D38CC0-8DD5-44E1-92B2-0F9E97A112CE@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <02D38CC0-8DD5-44E1-92B2-0F9E97A112CE@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Liu, Jiang" <gerry@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, slp@redhat.com, virtio-dev@lists.oasis-open.org, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 10, 2020 at 12:06:06AM +0800, Liu, Jiang wrote:
> On Jan 5, 2020, at 6:42 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >=20
> > On Thu, Dec 26, 2019 at 09:16:19PM +0800, Liu, Jiang wrote:
> >>> 2) The mask and unmask control is missed
> >>>=20
> >>>=20
> >>>> but the extension doesn=E2=80=99t support 3) because
> >>>> we noticed that the Linux virtio subsystem doesn=E2=80=99t really ma=
ke use of interrupt masking/unmasking.
> >=20
> > Linux uses masking/unmasking in order to migrate interrupts between
> > CPUs.
> This is a limitation of the PCI MSI/MSIx spec.
> To update the MSI/MSIx vector configuration, we need to write to msg_high=
/msg_low/msg_data registers.
> Because write to three 32-bit registers is not an atomic operation on PCI=
 bus, so it may cause incorrect interrupt delivery if interrupt happens aft=
er writing 1 or 2 registers.
> When Intel remapping is enabled on x86 platforms, we don=E2=80=99t need t=
o mask/unmask PCI MSI/MSIx interrupts when setting affinity.
> For MMIO MSI extension, we have special design to solve this race window.=
 The flow to update MMIO MSI vector configuration is:
> 1) write msg_high
> 2) write msg_low
> 3) write msg_data
> 4) write the command register to update the vector configuration.
> During step 1-3, the hardware/device backend driver only caches the value=
 written. And update the vector configuration in step 4, so it=E2=80=99s an=
 atomic operation now.
> So mask/unmask becomes optional for MMIO MSI interrupts.

Oh I see. That needs some documentation I guess.

One question though: how do you block VQ from generating interrupts?

There's value in doing that for performance since then device can avoid
re-checking interrupt enable/event idx values in memory.



> >=20
> > --=20
> > MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

