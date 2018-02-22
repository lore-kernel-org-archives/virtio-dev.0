Return-Path: virtio-dev-return-3266-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 760665818D8A
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Feb 2018 14:07:50 -0800 (PST)
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
Date: Thu, 22 Feb 2018 22:07:45 +0000
Message-ID: <A2CEFBAB-8FD1-4C55-B87A-770C9F080EC2@intel.com>
References: <20180222175250.97135.98386.stgit@mdrustad-mac04.local>
 <20180222182622.GA13815@infradead.org>
In-Reply-To: <20180222182622.GA13815@infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E24BEFD855DD514BB82292943B9C091D@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC PATCH V2] virtio_pci: Add SR-IOV support
To: Christoph Hellwig <hch@infradead.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Daly, Dan" <dan.daly@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "MRustad@gmail.com" <MRustad@gmail.com>, "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> On Feb 22, 2018, at 10:26 AM, Christoph Hellwig <hch@infradead.org> wrote=
:
>=20
> Can we move this into common code as a a generic_sriov_configure
> helper?  Nothing is really virtio specific, and it seems like
> some other drivers could also use it, e.g. ena or nvme.

That seems like a good idea to me, especially if PCI developers concur.

--=20
Mark Rustad, Networking Division, Intel Corporation


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

