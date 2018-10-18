Return-Path: virtio-dev-return-4901-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 404E1985E9B
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Oct 2018 23:40:59 +0000 (UTC)
Date: Thu, 18 Oct 2018 19:40:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181018192837-mutt-send-email-mst@kernel.org>
References: <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org>
 <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <20180927121739-mutt-send-email-mst@kernel.org>
 <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
 <20181002083928-mutt-send-email-mst@kernel.org>
 <CADGSJ23NaaPXrgoL1-ySs=SWytE65SORatOFMSapzFsKZUH4yA@mail.gmail.com>
 <20181005101419-mutt-send-email-mst@kernel.org>
 <CADGSJ22QYRX3GBjDqGgauwiHi6p4FpbUwpromD0=nY+w2FDm=Q@mail.gmail.com>
 <CADGSJ21XgTvbMF7b281O7qiXko=hA8nH9Cw2DZC+7Og=g4E3Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ21XgTvbMF7b281O7qiXko=hA8nH9Cw2DZC+7Og=g4E3Dw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Siwei Liu <loseweigh@gmail.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Cornelia Huck <cohuck@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, liran.alon@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 18, 2018 at 04:20:13PM -0700, Siwei Liu wrote:
> To be honest, I don't understand why there's resistance of using PV to
> initiate datapath switching,

I see no resistance. I see lack of man-power.  Any extension needs:
1- guest driver support
2- qemu support
3- spec documentation

Current scheme has (1) by now, a beginning of (3) and a rudimentary
prototype of (2).

For your proposed extension, you can either do some of this work, or do
some testing to demonstrate problems and motivate others. So far
emailing list about theoretical issues did not seem to motivate anyone.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

