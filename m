Return-Path: <virtio-dev-return-12315-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87724C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 16:08:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D1A812AF8B
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 16:08:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C86B898661B
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 16:08:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BCF7998643A; Wed, 19 Apr 2023 16:08:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A95A2986434;
	Wed, 19 Apr 2023 16:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Wed, 19 Apr 2023 18:08:39 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
        <shahafs@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230419180839.2add099d.pasic@linux.ibm.com>
In-Reply-To: <20230419014639.919458-3-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
	<20230419014639.919458-3-parav@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7_HkemP8iAYooUne2yA67w6kQ9wtPxTu
X-Proofpoint-ORIG-GUID: -3XtU2VqfGyPHAmhzRWcbHpYLx4rQdvs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_10,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190145
Subject: [virtio-dev] Re: [PATCH v14 02/11] content.tex Replace virtqueue number with
 index

On Wed, 19 Apr 2023 04:46:30 +0300
Parav Pandit <parav@nvidia.com> wrote:

> Replace virtqueue number with index to align to rest of the
> specification.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> changelog:
> v11->v12:
> - new patch
> ---
>  content.tex | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 43be58b..e79d722 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -405,7 +405,7 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>  this notification involves sending the
> -virtqueue number to the device (method depending on the transport).
> +virtqueue index to the device (method depending on the transport).

This is not entirely accurate. If VIRTIO_F_NOTIF_CONFIG_DATA was
negotiated it is not the virtqueue index that is sent but the
vq_notif_config_data.

>  
>  However, some devices benefit from the ability to find out the
>  amount of available data in the queue without accessing the virtqueue in memory:
> @@ -789,13 +789,13 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    buffer notifications.
>    As mentioned in section \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}, when the
>    driver is required to send an available buffer notification to the device, it
> -  sends the virtqueue number to be notified. The method of delivering
> +  sends the virtqueue index to be notified. The method of delivering
>    notifications is transport specific.
>    With the PCI transport, the device can optionally provide a per-virtqueue value
> -  for the driver to use in driver notifications, instead of the virtqueue number.
> +  for the driver to use in driver notifications, instead of the virtqueue index.
>    Some devices may benefit from this flexibility by providing, for example,
>    an internal virtqueue identifier, or an internal offset related to the
> -  virtqueue number.
> +  virtqueue index.
>  

And the above paragraph is supposed to make that point. 

I guess this is in some sense an improvement over the current state.
Thus:
Acked-by: Halil Pasic <pasic@linux.ibm.com>

But to get this really clean, we need to do some rewording here. Which
can be done on top of this series.


>    This feature indicates the availability of such value. The definition of the
>    data to be provided in driver notification and the delivery method is


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

