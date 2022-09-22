Return-Path: <virtio-dev-return-9965-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EEF1D9865F5
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Sep 2022 01:39:34 +0000 (UTC)
Message-ID: <5bab74d1-64fe-423c-32e8-c0047577bb68@redhat.com>
Date: Thu, 22 Sep 2022 09:39:22 +0800
MIME-Version: 1.0
References: <20220914144911.56422-1-gavinl@nvidia.com>
 <20220914144911.56422-2-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220914144911.56422-2-gavinl@nvidia.com>
Subject: [virtio-dev] Re: [PATCH v6 1/2] virtio-net: introduce and use helper function for
 guest gso support checks
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/9/14 22:49, Gavin Li =E5=86=99=E9=81=93:
> Probe routine is already several hundred lines.
> Use helper function for guest gso support check.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
> changelog:
> v4->v5
> - Addressed comments from Michael S. Tsirkin
> - Remove unnecessary () in return clause
> v1->v2
> - Add new patch
> ---
>   drivers/net/virtio_net.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e0e57083d442..f54c7182758f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3682,6 +3682,14 @@ static int virtnet_validate(struct virtio_device *=
vdev)
>   =09return 0;
>   }
>  =20
> +static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
> +{
> +=09return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> +=09=09virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> +=09=09virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> +=09=09virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO);
> +}
> +
>   static int virtnet_probe(struct virtio_device *vdev)
>   {
>   =09int i, err =3D -ENOMEM;
> @@ -3777,10 +3785,7 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>   =09spin_lock_init(&vi->refill_lock);
>  =20
>   =09/* If we can receive ANY GSO packets, we must allocate large ones. *=
/
> -=09if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> -=09    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> -=09    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> -=09    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> +=09if (virtnet_check_guest_gso(vi))
>   =09=09vi->big_packets =3D true;
>  =20
>   =09if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

