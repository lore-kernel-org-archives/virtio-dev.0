Return-Path: virtio-dev-return-6693-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE29D985F8B
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Jan 2020 10:14:40 +0000 (UTC)
Date: Wed, 29 Jan 2020 05:14:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200129051247-mutt-send-email-mst@kernel.org>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
 <1579614873-21907-6-git-send-email-jing2.liu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1579614873-21907-6-git-send-email-jing2.liu@linux.intel.com>
Subject: Re: [virtio-dev] [PATCH v2 5/5] virtio-mmio: MSI vector and event
 mapping
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Jing Liu <jing2.liu@linux.intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, Liu Jiang <gerry@linux.alibaba.com>, Zha Bin <zhabin@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 21, 2020 at 09:54:33PM +0800, Jing Liu wrote:
> Bit 1 msi_sharing reported in the MsiState register indicates the mapping=
 mode
> device uses.
>=20
> Bit 1 is 0 - device uses MSI non-sharing mode. This indicates vector per =
event and
> fixed static vectors and events relationship. This fits for devices with =
a high interrupt
> rate and best performance;
> Bit 1 is 1 - device uses MSI sharing mode. This indicates vectors and eve=
nts
> dynamic mapping and fits for devices not requiring a high interrupt rate.

It seems that sharing mode is a superset of non-sharing mode.
Isn't that right? E.g. with sharing mode drivers
can still avoid sharing if they like.

Maybe it should just be a hint to drivers whether to share
interrupts, instead of a completely different layout?

> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
>  content.tex | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  msi-state.c |  3 ++-
>  2 files changed, 49 insertions(+), 2 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index dcf6c71..2fd1686 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1770,7 +1770,8 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
>    \hline
>    \mmioreg{MsiState}{MSI state}{0x0c4}{R}{%
>      When VIRTIO_F_MMIO_MSI has been negotiated, reading
> -    from this register returns the global MSI enable/disable status.
> +    from this register returns the global MSI enable/disable status
> +    and whether device uses MSI sharing mode.
>      \lstinputlisting{msi-state.c}
>    }
>    \hline
> @@ -1926,12 +1927,18 @@ \subsubsection{Device Initialization}\label{sec:V=
irtio Transport Options / Virti
>  mask and unmask the MSI vector applying to the one selected by writing
>  to \field{MsiVecSel}.
> =20
> +VIRTIO_MMIO_MSI_CMD_MAP_CONFIG command is to set the configuration event=
 and MSI vector
> +mapping. VIRTIO_MMIO_MSI_CMD_MAP_QUEUE is to set the queue event and MSI=
 vector
> +mapping. They SHOULD only be used in MSI sharing mode.
> +
>  \begin{lstlisting}
>  #define  VIRTIO_MMIO_MSI_CMD_ENABLE           0x1
>  #define  VIRTIO_MMIO_MSI_CMD_DISABLE          0x2
>  #define  VIRTIO_MMIO_MSI_CMD_CONFIGURE        0x3
>  #define  VIRTIO_MMIO_MSI_CMD_MASK             0x4
>  #define  VIRTIO_MMIO_MSI_CMD_UNMASK           0x5
> +#define  VIRTIO_MMIO_MSI_CMD_MAP_CONFIG       0x6
> +#define  VIRTIO_MMIO_MSI_CMD_MAP_QUEUE        0x7
>  \end{lstlisting}
> =20
>  Setting a special NO_VECTOR value means disabling an interrupt for an ev=
ent type.
> @@ -1941,10 +1948,49 @@ \subsubsection{Device Initialization}\label{sec:V=
irtio Transport Options / Virti
>  #define VIRTIO_MMIO_MSI_NO_VECTOR             0xffffffff
>  \end{lstlisting}
> =20
> +\subparagraph{MSI Vector and Event Mapping}\label{sec:Virtio Transport O=
ptions / Virtio Over MMIO / MMIO-specific Initialization And Device Operati=
on / Device Initialization / MSI Vector Configuration}
> +The reported \field{msi_sharing} bit in the \field{MsiState} return valu=
e shows
> +the MSI sharing mode that device uses.
> +
> +When \field{msi_sharing} bit is 0, it indicates the device uses non-shar=
ing mode
> +and vector per event fixed static relationship is used. The first vector=
 is for device
> +configuraiton change event, the second vector is for virtqueue 1, the th=
ird vector
> +is for virtqueue 2 and so on.
> +
> +When \field{msi_sharing} bit is 1, it indicates the device uses MSI shar=
ing mode,
> +and the vector and event mapping is dynamic. Writing \field{MsiVecSel}
> +followed by writing VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_M=
AP_QUEUE command
> +maps interrupts triggered by the configuration change/selected queue eve=
nts respectively
> +to the corresponding MSI vector.
> +
> +\devicenormative{\subparagraph}{MSI Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over MMIO / MMIO-specific Initialization And Device Ope=
ration / MSI Vector Configuration}
> +
> +When the device reports \field{msi_sharing} bit as 0, it SHOULD support =
a number of
> +vectors that greater than the maximum number of virtqueues.
> +Device MUST report the number of vectors supported in \field{MsiVecNum}.
> +
> +When the device reports \field{msi_sharing} bit as 1, it SHOULD support =
at least
> +2 MSI vectors and MUST report in \field{MsiVecNum}. Device SHOULD suppor=
t mapping any
> +event type to any vector under \field{MsiVecNum}.
> +
> +Device MUST support unmapping any event type (NO_VECTOR).
> +
> +The device SHOULD restrict the reported \field{msi_sharing} and \field{M=
siVecNum}
> +to a value that might benefit system performance.
> +
> +\begin{note}
> +For example, a device which does not expect to send interrupts at a high=
 rate might
> +return \field{msi_sharing} bit as 1.
> +\end{note}
> +
>  \drivernormative{\subparagraph}{MSI Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over MMIO / MMIO-specific Initialization And Device Ope=
ration / MSI Vector Configuration}
>  When VIRTIO_F_MMIO_MSI has been negotiated, driver should try to configu=
re
>  and enable MSI.
> =20
> +To set up the event and vector mapping for MSI sharing mode, driver SHOU=
LD
> +write a valid \field{MsiVecSel} followed by VIRTIO_MMIO_MSI_CMD_MAP_CONF=
IG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE
> +command to map the configuration change/selected queue events respective=
ly.
> +
>  To configure MSI vector, driver SHOULD firstly specify the MSI vector in=
dex by
>  writing to \field{MsiVecSel}.
>  Then notify the MSI address and data by writing to \field{MsiAddrLow}, \=
field{MsiAddrHigh},
> diff --git a/msi-state.c b/msi-state.c
> index b1fa0c1..d470be4 100644
> --- a/msi-state.c
> +++ b/msi-state.c
> @@ -1,4 +1,5 @@
>  le32 {
>      msi_enabled : 1;
> -    reserved : 31;
> +    msi_sharing: 1;
> +    reserved : 30;
>  };
> --=20
> 2.7.4
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

