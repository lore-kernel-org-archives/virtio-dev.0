Return-Path: virtio-dev-return-3375-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 319235818F23
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 09:54:31 -0800 (PST)
Date: Fri, 2 Mar 2018 19:54:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302195256-mutt-send-email-mst@kernel.org>
References: <cover.1519961667.git.jbaron@akamai.com>
 <864430f2a613c4d3c82b591ed7bc27068ddad369.1519961667.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864430f2a613c4d3c82b591ed7bc27068ddad369.1519961667.git.jbaron@akamai.com>
Subject: [virtio-dev] Re: [PATCH 1/4] eth: add speed and duplex definitions
To: Jason Baron <jbaron@akamai.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 01, 2018 at 10:46:33PM -0500, Jason Baron wrote:
> Pull in definitions for SPEED_UNKNOWN, DUPLEX_UNKNOWN, DUPLEX_HALF,
> and DUPLEX_FULL.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtio-dev@lists.oasis-open.org
> ---
>  include/net/eth.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/net/eth.h b/include/net/eth.h
> index 09054a5..9843678 100644
> --- a/include/net/eth.h
> +++ b/include/net/eth.h
> @@ -417,4 +417,11 @@ bool
>  eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>                     size_t ip6hdr_off, eth_ip6_hdr_info *info);
>  
> +/* ethtool defines - from linux/ethtool.h */
> +#define SPEED_UNKNOWN           -1
> +
> +#define DUPLEX_HALF             0x00
> +#define DUPLEX_FULL             0x01
> +#define DUPLEX_UNKNOWN          0xff
> +
>  #endif

While that's not a lot, I think we should import linux/ethtool.h into
include/standard-headers/linux/ using scripts/update-linux-headers.sh

> -- 
> 2.7.4

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

