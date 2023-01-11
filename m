Return-Path: <mst@redhat.com>
Date: Wed, 11 Jan 2023 04:49:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [PATCH v7] virtio-net: support inner header hash
Message-ID: <20230111044530-mutt-send-email-mst@kernel.org>
References: <20230106015425-mutt-send-email-mst@kernel.org>
 <20230109024341.GA85179@h68b04307.sqa.eu95>
 <CACGkMEv_dppsyTW3TC8xymjgjB0iLDessoj1nVkHmpME2ACbtA@mail.gmail.com>
 <20230109062943-mutt-send-email-mst@kernel.org>
 <CACGkMEvjo8t_MhEXvn_u3R827105E1nHDRWku9j1ARWfH7yUPA@mail.gmail.com>
 <20230110002017-mutt-send-email-mst@kernel.org>
 <20230110005158-mutt-send-email-mst@kernel.org>
 <20230110072652.GA31460@h68b04307.sqa.eu95>
 <01ae626c-9316-4fd6-65be-41e229fd6316@linux.alibaba.com>
 <CACGkMEuXan9f4LqX0f+JGVytH-+uFkiWEJDnmq0bgm_GMNPhUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuXan9f4LqX0f+JGVytH-+uFkiWEJDnmq0bgm_GMNPhUA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 11, 2023 at 12:45:06PM +0800, Jason Wang wrote:
> On Wed, Jan 11, 2023 at 11:23 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
> >
> >
> >
> > 在 2023/1/10 下午3:26, Heng Qi 写道:
> > > On Tue, Jan 10, 2023 at 12:57:38AM -0500, Michael S. Tsirkin wrote:
> > >> On Tue, Jan 10, 2023 at 12:25:02AM -0500, Michael S. Tsirkin wrote:
> > >>>> This will give extra pressure on the management stack, e.g it requires
> > >>>> the device to have an out of spec way for introspection.
> > >>>>
> > >>>> Thanks
> > >>> As I tried to explain this is already the case. Feature bits do not
> > >>> describe device capabilities fully, some of them are in config space.
> 
> Yes.
> 
> > >> To be precise, this does not necessarily require introspection, but
> > >> it does require management control over config space
> > >> such as supported hash types just like it has control over feature bits.
> > >> E.g. QEMU currently seems to hard-code these to
> > >> #define VIRTIO_NET_RSS_SUPPORTED_HASHES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
> > >>                                           VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
> > >>                                           VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
> > >>                                           VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
> > >>                                           VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
> > >>                                           VIRTIO_NET_RSS_HASH_TYPE_UDPv6 | \
> > >>                                           VIRTIO_NET_RSS_HASH_TYPE_IP_EX | \
> > >>                                           VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
> > >>                                           VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
> > >>
> > >> but there's no reason not to give management control over these.
> 
> Note that the management expects the migration compatibility to work
> with machine types. So it needs a way to disable some tunnel hash
> types to make it work for old machine types.

yes. 
This means qemu will need to create properties for these things
and control through machine type compatibility machinery.
For those not hacking qemu - "machine type" is
a string roughly describing a version of guest/host interface used.


> > > Yes, QEMU has requirements for live migration: the PCI config space will be
> > > checked in get_pci_config_device(), and if src and dst are inconsistent, it
> > > will prompt that the live migration failed.
> 
> It might be too late since it can't work for the second run (unlike subsection).

This is really a low level detail of qemu. I'm not sure how important
this is for the spec.

> >
> > To be clearer, I mean \filed{supported_hash_types} in structure
> > virtio_net_config.
> 
> Yes.
> 
> Thanks
> 
> >
> > Thanks.
> >
> > > In fact, this is also done within our group. Live migration requires that
> > > the two VMs have the same rss configuration, otherwise the migration will fail.
> > >
> > > Therefore, it seems that we can regularize the description of VIRTIO_NET_F_HASH_TUNNEL into
> > > "[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner header hash for tunnel-encapsulated packets.",
> > > and use different hash_types to help the migration determine whether it can succeed.
> > >
> > > Thanks.
> > >
> > >> --
> > >> MST
> > > This publicly archived list offers a means to provide input to the
> > > OASIS Virtual I/O Device (VIRTIO) TC.
> > >
> > > In order to verify user consent to the Feedback License terms and
> > > to minimize spam in the list archive, subscription is required
> > > before posting.
> > >
> > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > List help: virtio-comment-help@lists.oasis-open.org
> > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > Committee: https://www.oasis-open.org/committees/virtio/
> > > Join OASIS: https://www.oasis-open.org/join/
> >

