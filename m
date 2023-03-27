Return-Path: <virtio-dev-return-11791-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03480C6FD1D
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:55:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A9BE47C279
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 398D29864A4
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2A7CA98634B; Mon, 27 Mar 2023 20:54:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2FA699864A8;
	Mon, 27 Mar 2023 20:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyAIsTGVXFKfwRhVKfVb3i+MfWONToWH6cEe/jOFpn7G04fmxwUNOh2NA1SoYRDq4XZ4pwXUzURLVWqjAaYHQCOr2nXOR+7amcyRrlrcVN2/FwKEuNQOIIpajargjHKv6nIqQ00Us00LuVipOLE7dYHjHNxp9W4EAnNRt4fVltJw3RXmUvAdt+1LTXQbzBY6dNmCEq/TyBWp4pYj14DNGA64wvGZd50I8zFLZqBjhtZrvGqYzon1c0BkBdIPcSSIjrvVSCqm2Ick7rUgqEOSG9T+0fqmOlObb8cG3sdTstoCuf4sYj582NJlViC3Lrhf9iN4x/C35StBKeMNSINm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcyMZN0RuyQjhc65CB01H31HgGj7Oro9NQwIVEqgGQk=;
 b=Pr9tV0O/yPq5YEE1i1J9tr/SRH2VKqWHwL9wrdWBkYDwzQ5HsVPZlS8+z8u7mjGb/MqkiKGbjBhbbpKYr4ySo13auJQYLpLCU+UxOVx1DjvkZPNWxDw9WVYGeo+ztWWCSy0dcOluPY4PDPuRAZEfEM5IdpFX35xa+WJyHdmcAScxi0NZEgF7wybXK/4/F0WfFyarsOedjdCrSsMN2L10f/ZfQnFJbBRI3n1lLkzVw8a+jaVBOjwQbqMpygIdCKuYcIk14P169pFBq3eGgWTMiyAuT4U6kWI9iY0XVJJwVmtEMGtfA48McFOCoClHG3avImLBxNFEwj/dzXQ9VaVZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Mon, 27 Mar 2023 23:53:58 +0300
Message-ID: <20230327205359.406605-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230327205359.406605-1-parav@nvidia.com>
References: <20230327205359.406605-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ce1d24-ed54-42ff-8ca7-08db2f0574d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nScxxyvZJK2rXittbMHLHwxutU2PPwr/RUFyvAZru9YY96ImOIWYrB4klmeO0+MFVBg4wQiRKemZG6+R/LNOrHV7rBfU7iK3w2i9bKuvi7MntCiCtmzbGYYvIFLsUYLp3r/nLR92Dt66vg6JCNXx9GU+DcRyd+jivxmRz5X201rqf5dW4kr43Okf0B6qfuEC/jMkJS8LzYkcEyQGPLlsPmnP2VJYjGqNFcpl5nnsakzqTCTo698fYg7G3eqAOY0uYYAFDdAK7VCugyEx2IGfAbRsq3cmgQT6/hNs64sSQtA9/COSFNUt/imtKK2A8FoNy3uAhMsTV69w0TSyN+h448sICgKtyUooHoiCS8Sy7zF/vfOwg4TJnQWpYkqrn/IX9hca4K9FFVOsfDpGN0gO0oyS2qE1AG6q/Fhgucw3fpMvyqROo7y50VSpim7LLMxkBFMmEtDLoxoqyHOaIZ/+StYzqk4AKLupAotOcLKUlkb5cp0sdaO8MDrNOmSpC8AzKu8ox7+aEe2xWPgiUVeL4/TxucH3UAeVgqcdPWIL+HM4nU4LTraE0MHM2La7DwJmAF5XagVVpVcROLXghfVyCrUB9FgfBJCiIpi78UiTyBk1oBfEP8Z/d8j3yC+uHmun9ksvPh8VMXJ1zurxK4xXIcxMtOujmEZ1AwGhydgzR+yUfB31Zf9SX8I9ZTIGlWY5/XNxv0eE8YTit3SXSmOErTy3hM/lSTNg18UtXiG4P2YL1FLmhXd0agqpUJtW/AklR+8UQLZBufvrSvQGJDtO5IGfJmO5LkSXA+ApPr+v7i0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(6666004)(186003)(26005)(966005)(1076003)(107886003)(47076005)(336012)(16526019)(4326008)(41300700001)(8936002)(70586007)(8676002)(5660300002)(110136005)(70206006)(316002)(54906003)(478600001)(40480700001)(2906002)(36756003)(86362001)(356005)(2616005)(426003)(36860700001)(83380400001)(7636003)(82740400003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 20:54:28.3341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ce1d24-ed54-42ff-8ca7-08db2f0574d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
Subject: [virtio-dev] [PATCH v7 7/8] virtio-net: Avoid duplicate receive queue example

Receive queue number/index example is duplicate which is already defined
in the Setting RSS parameters section.

Hence, avoid such duplicate example and prepare it for the subsequent
patch to describe using receive queue handle.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index d7c8b1b..435c1fc 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1467,8 +1467,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 The device MUST determine the destination queue for a network packet as follows:
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
-\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure (value of 0 corresponds to receiveq1).
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq (value of 0 corresponds to receiveq1).
+\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
+\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

