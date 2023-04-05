Return-Path: <virtio-dev-return-11992-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D03C76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 566E87297
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C07F4986646
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4B6229865A6; Wed,  5 Apr 2023 01:07:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E0C59865C1;
	Wed,  5 Apr 2023 01:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQEx+YSNL1mrG+J6d2kwB7h+dF8yi9uW03rX9NAwU/2I5kR+MSxYSKvRcHLuQfqhoY+q3eL5x79qoHAKknzhdwrqwh4LXXke+rLSXmqAoyQjHc88nvuPanX/H2gfqEjoO0bE2kSmjcbJuzgktD5hK40wegY2vJXPXfRzB/49UQSiUIvqe5qs+KnGs3n8alKWnTiFAsXFl5MdwIbd4BGutJbYzMneU62LksM3QiWfcA4++Nkg+HEzSwOB2CBcayEqYm85MPpLE9EjCEET1zH5zbFYSOQ/2Xdpcc10Q5yVFxUlNXrc72bag/SngTDP1tF+zhlehVXzq3rxGF3CVqU7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWKzBK/BAtOQ022fOUpiTUjJSmfN9nyDxrmYdRwHYjU=;
 b=GNBrRMhFrVYRQo5H3ht+0d1s1LAOZdGSu4pQAh0XNTA1lZd64r9/bVy9YvHSDk8atzb2mn5krE4lfhzL6E97Vyhe36rMVYorV0bxHFVdOsu3Ptx9Y9+UC+Ljtg6NSX/coGSGm+qP+S5/C/cZOb2S1D1bhBwqlXWZPRCfhlLotZP6GAj97FndL7qV9yt6kdn8IroXp91bM9FaiF920geACi5yuX9dZsW2QgPzWniEyFjVL4yZOy9rUBCMWU8VgQt7q9nDeKJqLfr2gWJAlGek1wIP1zwjWtAENDG7EsXZvmoP7vQFoymcm/GatdyvTGjYkkz02/ZdrdlRmGQIYZzN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 5 Apr 2023 04:06:51 +0300
Message-ID: <20230405010657.612529-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230405010657.612529-1-parav@nvidia.com>
References: <20230405010657.612529-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fd304a-3879-4a00-9726-08db35721ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MEPo+Y2T1gsHAZWmfj1pjz8vdB8lOJfNxU7mZZ/uPhse/hRD2OQ2p19LeimKwhcI1Skz/mYYjXC44E9w++QEt8uSJyDVxS+R8xVsNS/FBIN0sNbHNZ0iMdyjkiv4bmn8vs4RWCIvshzRURJQC1FRW9G9MNIQfkXi+yql5vY/tklB1aW12jNy1zFrq2hgbV20U0LiPw7QPlUys4o6bjL42DCwJ4BEPxTYWIuDjnvMrUbSCSu54GZo5YqE1C4OKeofloGgBzoZYVY1Z31jQ9aakLnd6p5HxFECyLQCC+62YCT3xckDOzlCEWd9tvHAF2Xw3JrAC0fx/PsT+jlACnsValnIxGuVZ4OkPT+vZgXKhObpXTE5czs+NshbZsxeK95dVwhuh/SDHyjx6aqc0uLUOxzfIP4EMv4Vf+gcZ/9y5Oo4WLCm2jzylrM2N/0sQW/23qGbNAxdGGOGmMwdmTB2MEHVdkRyVzA/VAl7yenJSpeX/4+Xr5kJ9hPVlekaqmts0Vc+lbZa2tsAJUAN18L54IYuWGk1NmML1f52tIJngdxtEBqwSPOjdGl3pjE3bAXbNdEez2KSmrPbXAT+PJ9376oP1g65TpnXXz/9Qf6i1dYlddHc1IM/tEkVF/rMZOd+/au+6xEdCycPYsaRrRCIdy3vNueER21Upld9yu3ve4HhBxQxYqAOZRMb5n9N3qcm6kZMmscc5gR3XaJtt6bGs9LMpvl2oPLqXo0fV06TMpIIt62hea26rKGxorHGsVlDBTiIRwus4+RSV6ZvcLWVfm5IgULDtX5Z0slOkiXAxrY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(82740400003)(70206006)(40460700003)(36860700001)(4326008)(70586007)(7636003)(8676002)(478600001)(41300700001)(54906003)(8936002)(316002)(110136005)(5660300002)(356005)(16526019)(6666004)(186003)(2616005)(966005)(426003)(336012)(83380400001)(107886003)(26005)(47076005)(1076003)(86362001)(82310400005)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 01:07:26.2966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fd304a-3879-4a00-9726-08db35721ef0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
Subject: [virtio-dev] [PATCH v12 04/10] transport-pci: Avoid first vq index reference

Drop reference to first virtqueue as it is already
covered now by the generic section in first patch.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v11->v12:
- drop changes related to vq number
v9->v10:
- updated commit log to drop reference to old patch
v8->v9:
- reword the sentence to avoid future tense, like rest of the other
  fields description
- reword the sentence to avoid multiple verbs use and put -> uses
- use shorter name 'vq number' instead of 'virtqueue number'
v7->v8:
- remove note about first virtqueue number
- skipped Max's comment to put word 'structure' in same line as its
  crosses 65 chars limit per line
- reworded queue_notification data set line, as '=' and vq number
  wording was odd
v2->v3:
- addressed comments from Michael
- changed vqn to virtqueue number in the Note
- refer to vqn field instead of virtqueue number
---
 transport-pci.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 6bbf61c..1e6604d 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1009,7 +1009,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the virtqueue index to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

