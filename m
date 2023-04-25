Return-Path: <virtio-dev-return-12401-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EB3C6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 10:59:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AD74E29FFF
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 10:59:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 92B21986456
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 10:59:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 82F3D98642D; Tue, 25 Apr 2023 10:59:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F73E98642F;
	Tue, 25 Apr 2023 10:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Tue, 25 Apr 2023 12:59:18 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
        <shahafs@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230425125918.6ff86375.pasic@linux.ibm.com>
In-Reply-To: <20230419014639.919458-7-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
 <20230419014639.919458-7-parav@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 06FrXIq5a5zUFNTFhlNWsX0mH5r06pCs
X-Proofpoint-ORIG-GUID: 5ExDtakTWNILSByvcBo-CZ1HmgHEqm8M
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250094
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v14 06/11] transport-mmio: Avoid
 referring to zero based index

On Wed, 19 Apr 2023 04:46:34 +0300
Parav Pandit <parav@nvidia.com> wrote:

> VQ range is already described in the first patch in basic virtqueue
> section. Hence remove the duplicate reference to it.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Acked-by: Halil Pasic <pasic@linux.ibm.com>

Same comments apply as for patch #4.

> 
> ---
> changelog:
> v12->v13:
> - corrected number to index
> v11->v12:
> - remove changes related to 'vq number'
> v8->v9:
> - added 'by' at two places
> - replaced 'queue number' with 'vq number'
> 
> v6->v7:
> - remove text around first vq as it is already covered in the basic
>   virtqueues facility section
> ---
>  transport-mmio.tex | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/transport-mmio.tex b/transport-mmio.tex
> index 164e640..2d24b4c 100644
> --- a/transport-mmio.tex
> +++ b/transport-mmio.tex
> @@ -113,8 +113,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      following operations on \field{QueueSizeMax},
>      \field{QueueSize}, \field{QueueReady},
>      \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
> -    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
> -    number of the first queue is zero (0x0).
> +    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to.
>    }
>    \hline
>    \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
> @@ -363,8 +362,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
>  The driver will typically initialize the virtual queue in the following way:
>  
>  \begin{enumerate}
> -\item Select the queue writing its index (first queue is 0) to
> -   \field{QueueSel}.
> +\item Select the queue by writing its index to \field{QueueSel}.
>  
>  \item Check if the queue is not already in use: read \field{QueueReady},
>     and expect a returned value of zero (0x0).
> @@ -474,9 +472,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>      Writing to this register selects the virtual queue that the
>      following operations on the \field{QueueSizeMax},
>      \field{QueueSize}, \field{QueueAlign}
> -    and \field{QueuePFN} registers apply to. The index
> -    number of the first queue is zero (0x0).
> -.
> +    and \field{QueuePFN} registers apply to.
>    }
>    \hline
>    \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
> @@ -550,8 +546,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>  
>  The virtual queue is configured as follows:
>  \begin{enumerate}
> -\item Select the queue writing its index (first queue is 0) to
> -   \field{QueueSel}.
> +\item Select the queue by writing its index to \field{QueueSel}.
>  
>  \item Check if the queue is not already in use: read \field{QueuePFN},
>     expecting a returned value of zero (0x0).


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

