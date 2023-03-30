Return-Path: <virtio-dev-return-11856-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056BCC6FD1D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 17:10:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2362341EEE
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 17:10:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19D5398657D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 17:10:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0CD9C986547; Thu, 30 Mar 2023 17:10:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED406986546;
	Thu, 30 Mar 2023 17:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Thu, 30 Mar 2023 19:10:19 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
        <shahafs@nvidia.com>, Max Gurtovoy
 <mgurtovoy@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230330191019.5a7a10c9.pasic@linux.ibm.com>
In-Reply-To: <20230329212341.465843-3-parav@nvidia.com>
References: <20230329212341.465843-1-parav@nvidia.com>
	<20230329212341.465843-3-parav@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dmmj9CJxmIG8dP6UCMamhLfbFxVVBvPF
X-Proofpoint-GUID: 7zld1hSaVPZ0Rd2zyiTjQUc-oiyZcKIt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300135
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 2/8] transport-pci: Refer to the vq
 by its number

On Thu, 30 Mar 2023 00:23:35 +0300
Parav Pandit <parav@nvidia.com> wrote:

> Currently specification uses virtqueue index and
> number interchangeably to refer to the virtqueue.
> 
> Instead refer to it by its number.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---

[..]

>  transport-pci.tex | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index b07a822..0f3a48b 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -390,13 +390,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  
>  \item[\field{queue_notify_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
> -        The driver will use this value to put it in the 'virtqueue number' field
> +        The driver uses this value in the field \field{vqn}

This is one of the problems with this approach... 

>          in the available buffer notification structure.
>          See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
>          \begin{note}
>          This field provides the device with flexibility to determine how virtqueues
>          will be referred to in available buffer notifications.
> -        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
> +        In a trivial case the device can set
> +        \field{queue_notify_data} to the vq number. Some devices

... the 'vq' number here is not the same vqn above which renders the usage
of vqn ambiguous. 

> @@ -1053,7 +1054,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>  If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
>  \begin{itemize}
>  \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
> -\field{queue_notify_data} value instead of the virtqueue index.
> +\field{queue_notify_data} value instead of the vq number.
>  \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
>  \field{vqn} field to the \field{queue_notify_data} value.

And here it is really obvious: if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated
the field \field{vqn} does not hold a virtqueue number/vq  nuber/vqn but
a device supplied identifier which may or may not be same as the vqn.

So we went 
from:
if !VIRTIO_F_NOTIF_CONFIG_DATA then vqn is the virtqueue index
if !!VIRTIO_F_NOTIF_CONFIG_DATA then vqn is queue_notify_data which may
or may not be the same as the virtqueue index
to
if !VIRTIO_F_NOTIF_CONFIG_DATA then vqn is the vq number
if !!VIRTIO_F_NOTIF_CONFIG_DATA then vqn is queue_notify_data which may
or may not be the same as the vq number.

Which is my opinion less clear that what we had before. And in my opinion
calling the very same thing virtqueue und vq number interchangeably is
not helpful either -- makes grepping harder.

I don't see the benefit of replacing virtqueue index with virtqueue
number. AFAIR the supposed benefit was to:
a) harmonize the terminology in the notifications part with the rest of
the spec
b) to resolve the RSS problematic with its receive virtqueue indexes.

For b) we are going down a different route calling those receive queue
ids (AFAIR), and for the notifications part see my comments above.

I'm about to reply to the cover letter, and make my argument against
standardizing virtqueue nuber (and in favor of standardizing on the
on virtqueue index) along with a diff that is supposed to act as
a counter proposal. If that doesn't work I will give up and make peace
with vq number and vqn.

Regards,
Halil 


>  \end{itemize}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

