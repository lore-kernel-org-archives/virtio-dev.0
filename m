Return-Path: <virtio-dev-return-9512-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 29 Apr 2022 15:19:59 +0000
Message-ID: <PH0PR12MB54813D60C1EB23ABDE8E4BC6DCFC9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220428221637.348443-1-parav@nvidia.com>
 <87fslwl3dj.fsf@redhat.com>
In-Reply-To: <87fslwl3dj.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v4] virtio: Improve queue_reset polarity to match to
 default reset state
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Friday, April 29, 2022 4:07 AM
>=20
> s/when/as long as/
>=20
> > +is ongoing. The device MUST present 0 in \field{queue_reset} and
> > +\field{queue_enable}
>=20
> s/in/in both/

>=20
> > +when queue reset completes.
>=20
> Maybe "when queue reset has completed"?
>=20

> s/when/as long as/
>=20
> > +is ongoing. The device MUST present 0 in \field{QueueReset} and
> > +\field{QueueReady}
>=20
> s/in/in both/
>=20
> > +when queue reset completes.
>=20
> Maybe "has completed" here as well.

Changing above entries in v5.
Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

