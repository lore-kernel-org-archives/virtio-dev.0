Return-Path: <virtio-comment-return-4231-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 14 Feb 2023 00:52:55 +0000
Message-ID: <PH0PR12MB54811FEFE616BC08CEE88E05DCA29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <PH0PR12MB54817FB7BA47369974018BAFDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230212044100-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230212044100-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v10 00/10] Introduce device group and device management
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, February 12, 2023 4:42 AM
>=20
> On Sat, Feb 11, 2023 at 06:49:52PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, February 9, 2023 7:13 AM
> >
> > [..]
> >
> > > My intent is to try and support both SR-IOV and SIOV usecases with
> > > the same structure and maybe even the same VQ.
> > >
> > Probably it is implicit, but is better for us to mention few examples
> > use cases here something like,
> >
> > Admin queue is an infrastructure to support use cases like:
> > a. SIOV devices life cycles management (create, destroy, query,
> > configure) b. SR-IOV VF device/resource management (SR-PCIM) c. May be
> > transport
> >
> > > For example, it might make sense to split creating/destroying SIOV
> > > devices from the transport passing data from the guest - the driver
> > > would then not negotiate VIRTIO_F_SR_IOV (which then means auto-
> provisioning).
> >
> > Above intermixing of SIOV and SR_IOV is very confusing.
> > Can you please drop it and have simpler examples like above?
>=20
> You mean in the cover letter? The more info in the cover letter the bette=
r, this
> stuff does not end up in git.
Yes, in the cover letter. Its ok its not in the git.
Maybe we can start also in the git. Sometimes it's useful for series like t=
his.
it is easy to review and digest the use of new feature introduction when th=
ose use cases are described in cover letter.

> I'll add your examples too though, thanks!
Ok thanks.

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

