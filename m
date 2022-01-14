Return-Path: <virtio-dev-return-9046-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0543B986507
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Jan 2022 10:38:28 +0000 (UTC)
Date: Fri, 14 Jan 2022 10:38:03 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <YeFSi0ObDs/Dlp4e@myrica>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-3-jasowang@redhat.com>
 <Yd6wZ2WMP0FMXWh8@stefanha-x1.localdomain>
 <CACGkMEtb7wGZ8oG-LwUNpFD2pJgEKGx6ttZHgWM686EN4A060A@mail.gmail.com>
 <Yd//qzpb7EJ1fa1y@stefanha-x1.localdomain>
 <20220113054324-mutt-send-email-mst@kernel.org>
 <YeA88PL9oOfphhoa@stefanha-x1.localdomain>
 <20220113101633-mutt-send-email-mst@kernel.org>
 <52c6adef-d38e-fcab-105d-0c21e4a2aac2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <52c6adef-d38e-fcab-105d-0c21e4a2aac2@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH V2 2/2] virtio-pci: add PASID
 configuration extended capability
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 14, 2022 at 11:15:35AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2022/1/13 =E4=B8=8B=E5=8D=8811:17, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> > On Thu, Jan 13, 2022 at 02:53:36PM +0000, Stefan Hajnoczi wrote:
> > > On Thu, Jan 13, 2022 at 05:45:11AM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Jan 13, 2022 at 10:32:11AM +0000, Stefan Hajnoczi wrote:
> > > > > > So my understanding is that instead of delaying the response to=
 read
> > > > > > it's better to simply present the previous PASID value if there=
're any
> > > > > > pending transactions of previous PASID value. The driver can th=
en
> > > > > > choose to poll or using timers etc.
> > > > Don't we limit these changes to before DRIVER_OK?
> > > > If we do then no previous transactions can exist.
> > > Not sure if that's possible for the vDPA virtqueue assignment use cas=
e
> > > where one large VIRTIO device provides virtqueues for many smaller vD=
PA
> > > devices?
>=20
>=20
> That could be the case but usually a smaller vDPA device requires a bunch=
 of
> hardware resources more than just virtqueues.
>=20
> Another example is assign a queue directly to userspace with PASID for SV=
A.
>=20
>=20
> > >=20
> > > Stefan
> > Then I guess queue must be stopped?
>=20
>=20
> Yes, since we have virtqueue reset, I can limit the assigning before
> DRIVER_OK or queue(s) are reset. Does this work?

Yes, I was wondering how this would work for the SVA use-case, where
processes can request queues from the virtio driver at runtime:

* Process opens a fd to the queue
* virtio driver selects a disabled queue, gets a PASID for that
  task and assigns it to the queue's group=20
* process mmaps its queue and works with it. When it is done, it closes
  the fd.
* virtio driver now makes sure that the virtqueue does not issue any
  more DMA with this PASID, it disables all the queues in the group by
  writing 1 to their queue_reset. After reset completes, it clears the
  group_pasid field.
* The driver releases the PASID (iommu_sva_unbind_device()).
  Both PASID and queue can now safely be assigned to other processes.

So making group_pasid field writeable only if all queues in the group are
disabled should work

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

