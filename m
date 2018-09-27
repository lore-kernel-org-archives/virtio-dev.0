Return-Path: virtio-dev-return-4876-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2C63985DA3
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Sep 2018 16:17:14 +0000 (UTC)
Date: Thu, 27 Sep 2018 12:17:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180927121621-mutt-send-email-mst@kernel.org>
References: <20180918122052.349ba42e.cohuck@redhat.com>
 <20180918093310-mutt-send-email-mst@kernel.org>
 <20180918151337.GA7432@vbusired-dt>
 <20180918111540-mutt-send-email-mst@kernel.org>
 <CADGSJ21CujSW=aF7BqdXmSFahLwSgPmG3_KFF5mSeVA5Z8PkQg@mail.gmail.com>
 <20180919230502-mutt-send-email-mst@kernel.org>
 <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org>
 <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <CAKPgXcEk9Pb_WKdywnQOixtfXGoER0BN82DwNBTjU=ajz53XcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPgXcEk9Pb_WKdywnQOixtfXGoER0BN82DwNBTjU=ajz53XcA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Sameeh Jubran <sameeh@daynix.com>
Cc: loseweigh@gmail.com, venu.busireddy@oracle.com, cohuck@redhat.com, sridhar.samudrala@intel.com, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 27, 2018 at 10:17:37AM +0300, Sameeh Jubran wrote:
> What do you think about the following alternative implementation which
> uses cross id validation.
> 
> -device virtio-net,standby=<device_id_of_vfio_device>,id=<device_id_of_virtio_net_device>
> -vfio #address,id=<device_id_of_vfio_device>,primary=<device_id_of_virtio_net_device>

virtio is a standby device, isn't it?

Besides that I don't see issues with this API.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

