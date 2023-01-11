Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <20230106002431-mutt-send-email-mst@kernel.org> <20230106064221.GA61196@h68b04307.sqa.eu95>
 <20230106015425-mutt-send-email-mst@kernel.org> <20230109024341.GA85179@h68b04307.sqa.eu95>
 <CACGkMEv_dppsyTW3TC8xymjgjB0iLDessoj1nVkHmpME2ACbtA@mail.gmail.com>
 <20230109062943-mutt-send-email-mst@kernel.org> <CACGkMEvjo8t_MhEXvn_u3R827105E1nHDRWku9j1ARWfH7yUPA@mail.gmail.com>
 <20230110002017-mutt-send-email-mst@kernel.org> <20230110005158-mutt-send-email-mst@kernel.org>
 <20230110072652.GA31460@h68b04307.sqa.eu95> <01ae626c-9316-4fd6-65be-41e229fd6316@linux.alibaba.com>
In-Reply-To: <01ae626c-9316-4fd6-65be-41e229fd6316@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Jan 2023 12:45:06 +0800
Message-ID: <CACGkMEuXan9f4LqX0f+JGVytH-+uFkiWEJDnmq0bgm_GMNPhUA@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v7] virtio-net: support inner header hash
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 11, 2023 at 11:23 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2023/1/10 =E4=B8=8B=E5=8D=883:26, Heng Qi =E5=86=99=E9=81=93:
> > On Tue, Jan 10, 2023 at 12:57:38AM -0500, Michael S. Tsirkin wrote:
> >> On Tue, Jan 10, 2023 at 12:25:02AM -0500, Michael S. Tsirkin wrote:
> >>>> This will give extra pressure on the management stack, e.g it requir=
es
> >>>> the device to have an out of spec way for introspection.
> >>>>
> >>>> Thanks
> >>> As I tried to explain this is already the case. Feature bits do not
> >>> describe device capabilities fully, some of them are in config space.

Yes.

> >> To be precise, this does not necessarily require introspection, but
> >> it does require management control over config space
> >> such as supported hash types just like it has control over feature bit=
s.
> >> E.g. QEMU currently seems to hard-code these to
> >> #define VIRTIO_NET_RSS_SUPPORTED_HASHES (VIRTIO_NET_RSS_HASH_TYPE_IPv4=
 | \
> >>                                           VIRTIO_NET_RSS_HASH_TYPE_TCP=
v4 | \
> >>                                           VIRTIO_NET_RSS_HASH_TYPE_UDP=
v4 | \
> >>                                           VIRTIO_NET_RSS_HASH_TYPE_IPv=
6 | \
> >>                                           VIRTIO_NET_RSS_HASH_TYPE_TCP=
v6 | \
> >>                                           VIRTIO_NET_RSS_HASH_TYPE_UDP=
v6 | \
> >>                                           VIRTIO_NET_RSS_HASH_TYPE_IP_=
EX | \
> >>                                           VIRTIO_NET_RSS_HASH_TYPE_TCP=
_EX | \
> >>                                           VIRTIO_NET_RSS_HASH_TYPE_UDP=
_EX)
> >>
> >> but there's no reason not to give management control over these.

Note that the management expects the migration compatibility to work
with machine types. So it needs a way to disable some tunnel hash
types to make it work for old machine types.

> > Yes, QEMU has requirements for live migration: the PCI config space wil=
l be
> > checked in get_pci_config_device(), and if src and dst are inconsistent=
, it
> > will prompt that the live migration failed.

It might be too late since it can't work for the second run (unlike subsect=
ion).

>
> To be clearer, I mean \filed{supported_hash_types} in structure
> virtio_net_config.

Yes.

Thanks

>
> Thanks.
>
> > In fact, this is also done within our group. Live migration requires th=
at
> > the two VMs have the same rss configuration, otherwise the migration wi=
ll fail.
> >
> > Therefore, it seems that we can regularize the description of VIRTIO_NE=
T_F_HASH_TUNNEL into
> > "[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner header hash for t=
unnel-encapsulated packets.",
> > and use different hash_types to help the migration determine whether it=
 can succeed.
> >
> > Thanks.
> >
> >> --
> >> MST
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.p=
df
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing=
-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
>

