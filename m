Return-Path: <virtio-dev-return-10956-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07FC598635C
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Feb 2023 11:13:01 +0000 (UTC)
Date: Mon, 13 Feb 2023 06:12:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230213061238-mutt-send-email-mst@kernel.org>
References: <20230213083019.826388-1-alvaro.karsz@solid-run.com>
 <CAJs=3_AtbBdtceGvUa6tsiCRKgpYg+nOibJ0eoA9h9u3fKJ5cA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_AtbBdtceGvUa6tsiCRKgpYg+nOibJ0eoA9h9u3fKJ5cA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL
 feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: parav@nvidia.com, jasowang@redhat.com, virtio-comment@lists.oasis-open.org, hengqi@linux.alibaba.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 13, 2023 at 10:33:32AM +0200, Alvaro Karsz wrote:
> Splitting this patch as suggested in v1 will be messy,
> 
> We have lines affected by multiple changes, for example:
> 
> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and
> \field{max_packets} parameters for all the receive virtqueues.
> 
> Is affected by the consolidation of the structs and by the statement
> that the command should apply to all virtqueues.
> 
> Do you think that this is ok to keep it as a single patch that makes
> multiple minor changes?

It is reasonably small so maybe ok.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

