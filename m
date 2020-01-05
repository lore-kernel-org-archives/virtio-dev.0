Return-Path: virtio-dev-return-6589-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93EC19841DA
	for <virtio-dev@lists.oasis-open.org>; Sun,  5 Jan 2020 10:42:59 +0000 (UTC)
Date: Sun, 5 Jan 2020 05:42:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200105054142-mutt-send-email-mst@kernel.org>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
 <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Liu, Jiang" <gerry@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, slp@redhat.com, virtio-dev@lists.oasis-open.org, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Dec 26, 2019 at 09:16:19PM +0800, Liu, Jiang wrote:
> > 2) The mask and unmask control is missed
> >=20
> >=20
> >>  but the extension doesn=E2=80=99t support 3) because
> >> we noticed that the Linux virtio subsystem doesn=E2=80=99t really make=
 use of interrupt masking/unmasking.

Linux uses masking/unmasking in order to migrate interrupts between
CPUs.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

