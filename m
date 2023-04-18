Return-Path: <virtio-dev-return-12287-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28F9C77B78
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 16:55:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C24384434B
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 16:55:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B9D9E98641F
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 16:55:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B0107986408; Tue, 18 Apr 2023 16:55:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BDEA98640E;
	Tue, 18 Apr 2023 16:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Tue, 18 Apr 2023 18:54:57 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
        <shahafs@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230418185457.66df510f.pasic@linux.ibm.com>
In-Reply-To: <20230411192341.751841-9-parav@nvidia.com>
References: <20230411192341.751841-1-parav@nvidia.com>
	<20230411192341.751841-9-parav@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fQUlsjBVtBYcm4JrKuy1FkBICQUNEfpt
X-Proofpoint-ORIG-GUID: fTrQsQAfn6zSdb2QMCuJhyZsU3xBzn9d
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180138
Subject: [virtio-dev] Re: [PATCH v13 08/11] transport-ccw: Refer to the vq by its index

On Tue, 11 Apr 2023 22:23:38 +0300
Parav Pandit <parav@nvidia.com> wrote:

> Currently specification uses virtqueue index and
> number interchangeably to refer to the virtqueue.
> 
> Instead refer to it by its index.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> ---
> changelog:
> v11->v12:
> - removed changes related to index
> - replace number with index
> - added 'only' to make it more clear that
>   notification has only vq index
> v9->v10:
> - replaced queue_select with vqn
> - used lower case letter for first word in comment
> v8->v9:
> - replaced 'named' with 'known'
> - replaced 'queue number' with 'vq number'
> v3->v4:
> - moved note to comment
> v2->v3:
> - added comment note for queue_select similar to max_queue_size
> v0->v1:
> - new patch
> ---
>  transport-ccw.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/transport-ccw.tex b/transport-ccw.tex
> index cb476c7..86272d1 100644
> --- a/transport-ccw.tex
> +++ b/transport-ccw.tex
> @@ -545,7 +545,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Vi
>  \end{tabular}
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> -the \field{Notification data} contains the Virtqueue number.
> +the \field{Notification data} contains the virtqueue index.
>  
>  When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
>  the value has the following format:


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

