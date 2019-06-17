Return-Path: virtio-comment-return-746-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 17 Jun 2019 14:38:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190617143845-mutt-send-email-mst@kernel.org>
References: <20190222115433.7160-1-dgilbert@redhat.com>
 <CAEkmjvU5q46v0cvFx31jfjHZuih8hyxF=9f-h8BdALb4k+bzdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEkmjvU5q46v0cvFx31jfjHZuih8hyxF=9f-h8BdALb4k+bzdg@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH v2 0/3] Large shared memory regions
To: Frank Yang <lfy@google.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 05, 2019 at 07:47:52AM -0800, Frank Yang wrote:
>=20
>=20
> On Fri, Feb 22, 2019 at 3:54 AM Dr. David Alan Gilbert (git) <
> dgilbert@redhat.com> wrote:
>=20
>     From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
>     Hi,
>     =A0 This series formalises the idea of shared memory regions I'd
>     previously discussed and is intended for use with virtio-fs.
>=20
>     I've split it into three parts:
>=20
>     =A0 a) A general definition of the idea
>=20
>     =A0 b) A definition on virtio-pci using the layout previously
>     discussed; this still uses the list of capabilities.
>=20
>     =A0 c) A definition on virtio-mmio; this is untested
>     however I thought best to include it since it shows that
>     it isn't tied to PCI.
>=20
>=20
>     This v2 addresses (hopefully all) comments from the initial posting,
>     except for CCW and the GPU/dynamic usage currently being
>     discussed by Frank.=A0 Cornelia has a suggested approach for CCW
>     that is being discussed, so it looks like we're getting there on
>     that.=A0 The GPU usage being discussed by Frank is diverging to a
>     very different usage.
>=20
>=20
> =A0
> I've modified the virtio-hostmem stuff to not be dynamic (and posted it);
> I think we can get that kind of usage using your current definitions.

OK that's an ack then?

>=20
>     Dave
>=20
>     Dr. David Alan Gilbert (3):
>     =A0 shared memory: Define shared memory regions
>     =A0 shared memory: Define PCI capability
>     =A0 shared memory: Define mmio registers
>=20
>     =A0content.tex=A0 =A0 | 71 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>     =A0shared-mem.tex | 33 +++++++++++++++++++++++
>     =A02 files changed, 104 insertions(+)
>     =A0create mode 100644 shared-mem.tex
>=20
>     --
>     2.20.1
>=20
>=20
>     This publicly archived list offers a means to provide input to the
>     OASIS Virtual I/O Device (VIRTIO) TC.
>=20
>     In order to verify user consent to the Feedback License terms and
>     to minimize spam in the list archive, subscription is required
>     before posting.
>=20
>     Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>     Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>     List help: virtio-comment-help@lists.oasis-open.org
>     List archive: https://lists.oasis-open.org/archives/virtio-comment/
>     Feedback License: https://www.oasis-open.org/who/ipr/feedback_license=
.pdf
>     List Guidelines: https://www.oasis-open.org/policies-guidelines/
>     mailing-lists
>     Committee: https://www.oasis-open.org/committees/virtio/
>     Join OASIS: https://www.oasis-open.org/join/
>=20
>=20

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

