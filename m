Return-Path: virtio-dev-return-6828-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C42339843EF
	for <virtio-dev@lists.oasis-open.org>; Sun,  1 Mar 2020 20:06:54 +0000 (UTC)
Date: Sun, 1 Mar 2020 15:06:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200301150625-mutt-send-email-mst@kernel.org>
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200301143302.8556-1-yuri.benditovich@daynix.com>
Subject: [virtio-dev] Re: [PATCH v3 0/3] virtio-net: introduce features defined in the spec
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yan@daynix.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Mar 01, 2020 at 04:32:59PM +0200, Yuri Benditovich wrote:
> This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
> VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.
>=20
> Changes from v2: reformatted structure in patch 1


Looks good but I cound a couple more nits. Sorry I missed them
on the previous read.

> Yuri Benditovich (3):
>   virtio-net: Introduce extended RSC feature
>   virtio-net: Introduce RSS receive steering feature
>   virtio-net: Introduce hash report feature
>=20
>  include/uapi/linux/virtio_net.h | 100 ++++++++++++++++++++++++++++++--
>  1 file changed, 96 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

