Return-Path: <virtio-dev-return-12353-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1255C7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 13:10:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EDFD726A30
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 13:10:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E805B9863D7
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 13:10:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DBAE2986350; Mon, 24 Apr 2023 13:10:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C929D98634E;
	Mon, 24 Apr 2023 13:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Mon, 24 Apr 2023 15:10:00 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
        <shahafs@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230424151000.3b494f3b.pasic@linux.ibm.com>
In-Reply-To: <20230419014639.919458-10-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
	<20230419014639.919458-10-parav@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qaqXLRuw7fyGJr6t88zuQ3s3GGLn2xLz
X-Proofpoint-GUID: fPxm0zEeEsm22WD3_IwKKMTSVUEKetMS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=909
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304240118
Subject: Re: [virtio-dev] [PATCH v14 09/11] virtio-net: Avoid duplicate
 receive queue example

On Wed, 19 Apr 2023 04:46:37 +0300
Parav Pandit <parav@nvidia.com> wrote:

> Receive queue number/index example is duplicate which is already defined
> in the Setting RSS parameters section.
> 
> Hence, avoid such duplicate example and prepare it for the subsequent
> patch to describe using receive queue handle.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

