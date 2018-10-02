Return-Path: virtio-dev-return-4883-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83A21985D6D
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Oct 2018 12:43:51 +0000 (UTC)
Date: Tue, 2 Oct 2018 08:43:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181002083928-mutt-send-email-mst@kernel.org>
References: <20180918093310-mutt-send-email-mst@kernel.org>
 <20180918151337.GA7432@vbusired-dt>
 <20180918111540-mutt-send-email-mst@kernel.org>
 <CADGSJ21CujSW=aF7BqdXmSFahLwSgPmG3_KFF5mSeVA5Z8PkQg@mail.gmail.com>
 <20180919230502-mutt-send-email-mst@kernel.org>
 <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org>
 <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <20180927121739-mutt-send-email-mst@kernel.org>
 <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Siwei Liu <loseweigh@gmail.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Cornelia Huck <cohuck@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 02, 2018 at 01:42:09AM -0700, Siwei Liu wrote:
> The VF's MAC can be updated by PF/host on the fly at any time. One can
> start with a random MAC but use group ID to pair device instead. And
> only update MAC address to the real one when moving MAC filter around
> after PV says OK to switch datapath.
> 
> Do you see any problem with this design?

Isn't this what I proposed:
	Maybe we can
	start VF with a temporary MAC, then change it to a final one when guest
	tries to use it. It will work but we run into fact that MACs are
	currently programmed by mgmnt - in many setups qemu does not have the
	rights to do it.

?

If yes I don't see a problem with the interface design, even though
implementation wise it's more work as it will have to include management
changes.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

