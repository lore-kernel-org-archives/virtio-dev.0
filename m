Return-Path: <virtio-comment-return-3704-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 9 Jan 2023 10:43:41 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
Message-ID: <20230109024341.GA85179@h68b04307.sqa.eu95>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <20230106002431-mutt-send-email-mst@kernel.org>
 <20230106064221.GA61196@h68b04307.sqa.eu95>
 <20230106015425-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230106015425-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v7] virtio-net:
 support inner header hash
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 06, 2023 at 01:59:38AM -0500, Michael S. Tsirkin wrote:
> On Fri, Jan 06, 2023 at 02:42:21PM +0800, Heng Qi wrote:
> > On Fri, Jan 06, 2023 at 12:27:04AM -0500, Michael S. Tsirkin wrote:
> > > On Wed, Jan 04, 2023 at 03:14:01PM +0800, Heng Qi wrote:
> > > > If the tunnel is used to encapsulate the packets, the hash calculated
> > > > using the outer header of the receive packets is always fixed for the
> > > > same flow packets, i.e. they will be steered to the same receive queue.
> > > > 
> > > > We add a feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks
> > > > in \field{hash_types}, which instructs the device to calculate the
> > > > hash using the inner headers of tunnel-encapsulated packets. Besides,
> > > > values in \field{hash_report_tunnel} are added to report tunnel types.
> > > > 
> > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/151
> > > > 
> > > > Reviewed-by: Jason Wang <jasowang@redhat.com>
> > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > 
> > > 
> > > ok close to being ready. a couple of minor comments.
> > > 
> > > > ---
> > > > v6:
> > > > 	1. Modify the wording of some sentences for clarity. @Michael S. Tsirkin
> > > > 	2. Fix some syntax issues. @Michael S. Tsirkin
> > > > 
> > > > v5:
> > > > 	1. Fix some syntax and capitalization issues. @Michael S. Tsirkin
> > > > 	2. Use encapsulated/encaptulation uniformly. @Michael S. Tsirkin
> > > > 	3. Move the links to introduction section. @Michael S. Tsirkin
> > > > 	4. Clarify some sentences. @Michael S. Tsirkin
> > > > 
> > > > v4:
> > > > 	1. Clarify some paragraphs. @Cornelia Huck
> > > > 	2. Fix the u8 type. @Cornelia Huck
> > > > 
> > > > v3:
> > > > 	1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_HASH_TUNNEL. @Jason Wang
> > > > 	2. Make things clearer. @Jason Wang @Michael S. Tsirkin
> > > > 	3. Keep the possibility to use inner hash for automatic receive steering. @Jason Wang
> > > > 	4. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc. many times. @Michael S. Tsirkin
> > > > 
> > > > v2:
> > > > 	1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
> > > > 	2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wang, @Michael S. Tsirkin
> > > > 
> > > > v1:
> > > > 	1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
> > > > 	2. Clarify some paragraphs. @Jason Wang
> > > > 	3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich
> > > > 
> > > >  content.tex      | 191 +++++++++++++++++++++++++++++++++++++++++++++--
> > > >  introduction.tex |  19 +++++
> > > >  2 files changed, 203 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/content.tex b/content.tex
> > > > index e863709..7845f6c 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> > > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> > > >      channel.
> > > >  
> > > > +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner
> > > > +    header hash for GRE, VXLAN and GENEVE tunnel-encapsulated packets.
> > > 
> > > I would probably drop the list of tunnel types here.
> > 
> > Do you mean to use "Device supports inner header hash for
> > tunnel-encapsulated packets." instead? Why? We do want to use this
> > feature bit to indicate that the device supports inner hashing of
> > GRE, VXLAN and GENEVE encapsulated packets. As in the v3 discussion
> > https://lists.oasis-open.org/archives/virtio-dev/202212/msg00024.html ,
> > we discussed using VIRTIO_NET_F_HASH_TUNNEL to replace
> > VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER and plan to use
> > VIRTIO_NET_F_HASH_TUNNEL_XYZ for future extensions.
> 
> So imagine we add a new tunnel type. Let's say there's VXLAN v2.
> why would we need a new feature bit? I think a new hash type
> will be sufficient. No?

If the description for VIRTIO_NET_F_HASH_TUNNEL is as follows:
"[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner header hash for tunnel-encapsulated packets.".
Then the following may happen
1. For VXLANv2, if both device src and device dst have negotiated this feature, it is assumed that
   device src supports VXLAN and VXLANv2, but device dst may only support VXLAN, not VXLANv2.
2. For other encapsulation protocols such as ip in ip, after device src and device dst have
   negotiated this feature, it is assumed that device src supports GRE, VXLAN, GENEVE and ip in ip,
   but it is not clear that device dst also supports ip in ip. Especially when migrating, this can
   lead to inconsistencies in live migrations.
So, I think it's better to keep the original description:
"[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner header hash for GRE, VXLAN and GENEVE tunnel-encapsulated packets."

Thanks.

> 
> -- 
> MST
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

