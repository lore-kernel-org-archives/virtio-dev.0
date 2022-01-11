Return-Path: <virtio-dev-return-9015-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59D23986438
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Jan 2022 15:00:53 +0000 (UTC)
MIME-Version: 1.0
message-id: <1641913138.0366013-1-xuanzhuo@linux.alibaba.com>
date: Tue, 11 Jan 2022 22:58:58 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
in-reply-to: <87zgo2wcij.fsf@redhat.com>
Subject: [virtio-dev] Re: [PATCH v8] virtio-net: support device stats
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 11 Jan 2022 15:52:20 +0100, Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, Jan 11 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > This patch allows the driver to obtain some statistics from the device.
> >
> > In the back-end implementation, we can count a lot of such information,
> > which can be used for debugging and judging the running status of the
> > back-end. We hope to directly display it to the user through ethtool.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Jason Wang <jasowang@redhat.com>
> > ---
> >
> > v8:
> > 1. Modified based on comments by Cornelia Huck
> >
> > v7:
> > 1. add rx_reset, tx_reset
> > 2. add device normative and dirver normative
> > 3. add comments for *_packets, *_bytres
> >
> > v6:
> > 1. correct the names and descriptions of some stats items
> >
> > v5:
> > 1. add VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ
> > 2. more item for virtio_net_ctrl_reply_stats_queue_pair
> >
> > v4:
> > 1. remove dev_stats_num, {rx|tx}_stats_num
> > 2. Use two commands to get the stats of queue pair and dev respectively
> >
> > v3 changes:
> > 1. add dev_version
> > 2. use queue_pair_index replace rx_num, tx_num
> > 3. Explain the processing when the device and driver support different numbers
> > of stats
> >
> >  conformance.tex |   2 +
> >  content.tex     | 133 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 134 insertions(+), 1 deletion(-)
>
> LGTM.
>
> Unless someone else spots a problem, I think this is ready to vote on,
> so please open a github issue and link it here.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/130

>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

