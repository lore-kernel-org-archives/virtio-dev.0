Return-Path: virtio-dev-return-7121-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD157986077
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 10:29:25 +0000 (UTC)
Date: Fri, 17 Apr 2020 06:29:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200417062804-mutt-send-email-mst@kernel.org>
References: <20200417021335-mutt-send-email-mst@kernel.org>
 <08d2c4e2-8c0f-7d3c-89f1-0e6c6a2756c8@redhat.com>
 <20200417044641-mutt-send-email-mst@kernel.org>
 <0f867029-aef4-72b9-356f-ec25c265db1b@redhat.com>
 <20200417051223-mutt-send-email-mst@kernel.org>
 <3447361c-4d07-1785-c59b-8c98ddaebd92@redhat.com>
 <20200417055217-mutt-send-email-mst@kernel.org>
 <1823d9be-d175-6cb5-0c7d-8a68d959a0d5@redhat.com>
 <20200417061815-mutt-send-email-mst@kernel.org>
 <34f46dfc-be16-d057-0760-3cb7c1d1288a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <34f46dfc-be16-d057-0760-3cb7c1d1288a@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 17, 2020 at 12:26:24PM +0200, David Hildenbrand wrote:
> On 17.04.20 12:19, Michael S. Tsirkin wrote:
> > On Fri, Apr 17, 2020 at 12:09:38PM +0200, David Hildenbrand wrote:
> >>  > What do you call "hinting ends" though? The fact we put
> >>> a page in the VQ is not a guarantee that it's been consumed
> >>> by the hypervisor.
> >>>
> >>
> >> I'd say hinting ends once the hypervisor sets FREE_PAGE_REPORT_S_DONE.
> >=20
> > Can't find that one anywhere. what did I miss?
>=20
> Sorry, the QEMU implementation is confusing. FREE_PAGE_REPORT_S_DONE is
> translated to VIRTIO_BALLOON_CMD_ID_DONE

Well VIRTIO_BALLOON_CMD_ID_DONE just means "don't give me any
more hints, I finished migration".
Guest will stop hinting even without that once it scans all
free memory.



> QEMU:
>=20
> hw/virtio/virtio-balloon.c:virtio_balloon_free_page_report_notify()
> -> virtio_balloon_free_page_done(dev)
> -> s->free_page_report_status =3D FREE_PAGE_REPORT_S_DONE;
>    virtio_notify_config(vdev);
>=20
> When the guest reads the config
> hw/virtio/virtio-balloon.c:virtio_balloon_get_config()
> -> if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_DONE)
> -> config.free_page_report_cmd_id =3D ... VIRTIO_BALLOON_CMD_ID_DONE
>=20
>=20
> Linux:
>=20
> drivers/virtio/virtio_balloon.c:report_free_page_func()
> -> if (cmd_id_received =3D=3D VIRTIO_BALLOON_CMD_ID_DONE) {
> -> return_free_pages_to_mm()
>=20
>=20
> So it's VIRTIO_BALLOON_CMD_ID_DONE.
>=20
>=20
> --=20
> Thanks,
>=20
> David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

