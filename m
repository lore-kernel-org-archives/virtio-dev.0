Return-Path: virtio-dev-return-4710-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Fri, 20 Jul 2018 09:44:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180720094450.2f2978f9.cohuck@redhat.com>
In-Reply-To: <1532035780-38883-1-git-send-email-sridhar.samudrala@intel.com>
References: <1532035780-38883-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, Sridhar@lists.oasis-open.org, "Samudrala <sridhar.samudrala"@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 19 Jul 2018 14:29:40 -0700
Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:

> VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
> driver to act as a standby for another device with the same MAC address.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com
> ---
>  content.tex | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index be18234..010b6ee 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2525,6 +2525,9 @@ features.
>  
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
> +
> +\item[VIRTIO_NET_F_STANDBY(62)] Driver acts as standby for another
> +    device with the same MAC

Isn't it the _device_ that acts as the standby?

>  \end{description}
>  
>  \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device / Feature bits / Feature bit requirements}
> @@ -2636,6 +2639,13 @@ If the driver negotiates VIRTIO_NET_F_MTU, it MUST NOT transmit packets of
>  size exceeding the value of \field{mtu} (plus low level ethernet header length)
>  with \field{gso_type} NONE or ECN.
>  
> +A driver SHOULD negotiate VIRTIO_NET_F_STANDBY feature if the device offers it.

I'm not sure that this is the right section of the spec. Maybe we need
a new normative driver section for "cross-device features" (better
names wanted :), and the same for devices?

> +
> +If the driver negotiates VIRTIO_NET_F_STANDBY, it should act as a standby for
> +another device with the same MAC address when available. The hypervisor can
> +hot-plug a primary device with same MAC address if the feature is successfully
> +negotiated with the driver.

I don't think you should add implementation details like hotplugging
into the spec.

What about:

"If the driver negotiates VIRTIO_NET_F_STANDBY, the device MAY act as a
standby device for another device with the same MAC address, the
'failover device'. The 'failover device' MUST NOT [or maybe SHOULD
NOT?] be accessible if VIRTIO_NET_F_STANDBY has not been negotiated by
the driver."

One thing that makes defining the behaviour of this feature bit a bit
difficult is that you need to describe both what the virtio device and
driver are supposed to be doing (which is what this spec is all about)
and also the behaviour of the hypervisor. Maybe it would be good to keep
the normative statements, and add an explanatory section describing in
more detail what the hypervisor is to do and what the guest can expect?

> +
>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
>  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout / Legacy Interface: Device configuration layout}
>  When using the legacy interface, transitional devices and drivers


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

