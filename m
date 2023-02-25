Return-Path: <virtio-dev-return-11280-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sat, 25 Feb 2023 21:40:11 +0000
Message-ID: <PH0PR12MB5481FEA749E0417D7BBCC39ADCA99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230224231232.340814-1-parav@nvidia.com>
 <20230224231232.340814-2-parav@nvidia.com>
 <20230225124225-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230225124225-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH 1/2] transport-pci: Use capital alphabets
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, February 25, 2023 12:46 PM
> >  Transitional devices MUST have the Transitional PCI Device ID in -the
> > range 0x1000 to 0x103f.
> > +the range 0x1000 to 0x103F.
>=20
> I actually think upper case A-F is inconsistent with lower case 0x.  So I=
 would say
> if we are going to worry about it, let's make them all lowercase.

:)
0x notion read far better than 0X to represent hex.
But all in lowercase is equally fine as long as it is consistent.
Will change it.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

