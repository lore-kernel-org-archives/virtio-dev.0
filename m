Return-Path: virtio-dev-return-3310-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C94DA58191BD
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2018 14:45:23 -0800 (PST)
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
Date: Tue, 27 Feb 2018 22:45:19 +0000
Message-ID: <CABB6175-4FC3-4742-9C54-FCDEE3E5A608@intel.com>
References: <20180226031911.18980.80488.stgit@mdrustad-mac04.local>
 <20180227.103502.2160088807348773566.davem@davemloft.net>
In-Reply-To: <20180227.103502.2160088807348773566.davem@davemloft.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB59E9BAE7B06A408C67D7E856C619DF@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC PATCH V3] virtio_pci: Add SR-IOV support
To: David Miller <davem@davemloft.net>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Daly, Dan" <dan.daly@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "MRustad@gmail.com" <MRustad@gmail.com>, "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> On Feb 27, 2018, at 7:35 AM, David Miller <davem@davemloft.net> wrote:
>=20
> I don't like these helpers on many different levels.

<snip much embarrassment>

> So kill off pci_sriov_enable() helper completely, it is unnecessary,
> and rename the disable helper so that it says something meaningful to
> the reader.

Yes. Once pointed out, I completely agree with your comments and wish that =
I had seen those things myself.

> Thanks.

V3 was junk, but your comments apply to V4 as well, so please ignore it.

Thank you for your valuable review.

--=20
Mark Rustad, Networking Division, Intel Corporation


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

