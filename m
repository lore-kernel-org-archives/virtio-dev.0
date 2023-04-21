Return-Path: <virtio-dev-return-12344-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480AFC77B71
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:55:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AEEAC44549
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:55:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1BBA8986730
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:55:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D2E2A9866F3; Fri, 21 Apr 2023 14:55:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C82098668A;
	Fri, 21 Apr 2023 14:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBBTDxazYPTTZY8phBzPohL+GFRgM+VQV0eMukm2LPEmquSYprQGTSmhQ6OFD3ppX1IaheEBFNNsjUABC98VgvvKPsDk1HJaASI9aSp5xzAG5P8eeeo/sKE34boHakG8k7GEdmjgMjPDUXykjluwBlIJhd9IZIlYU4MDoXA4C0Oe1ZtxtzXIoVO26bnIeJCy0NeEf17kYYJ9IKjNj0Vbymnmxhl5fK0vEYockRTPiSZLRDPFzpqdp9rhB3TdkQW5ypYYuJQ7Ix+BV8Q6LN5aGNoF3x1A6QuJt6sHc5qJf1HK7Q0imUmvvSBpDEK6u7VvFbK49w694BUjQoQfGUw4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQMUGHUQfPruf34x/uNWjuPgpj+QwZyfmJ1eECsGyqo=;
 b=b9l7Nub6cUlRyMZst+2TUi/zMeHPojpQro+mqjn3F8UoPyPIFITq/IQBgZrhqMBd3KB2YUm03kIuauH+vzVmlK5iGXueAmGM22F4sV+v7IQP92PPsCa0r7gx1hS6zkXajZlpVap9lhkiKWOGFc7HeNELImXr2ObBvbhr3JsYHt6SkVnsIBEzUKdxV8JfR2vYcir19aHm74+GCwXfpVzlTr/rrCL7UU3Ea/VVCbi+5cRSkDjdcX8qV4hTMdVwNZhhOG829XTQsKurGcG6yOsNoDYxR9eM6XMzx5DffKhyNYGGgcTnlcCkYkUJZZabGE/FvR/J42uPCmShpZajgE/41w==
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
	<parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Fri, 21 Apr 2023 17:54:33 +0300
Message-ID: <20230421145434.83774-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230421145434.83774-1-parav@nvidia.com>
References: <20230421145434.83774-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b633cf-b6f3-4762-be3a-08db427860bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vOpaB0jUS1zw10/5jMDr3muEVRC+B55sw0q41Y1MnBEUNbRl7qUPjJ2fqMRFyTJK6i3mILBOZytkAtNtsaDgADC273muigN5/AzvX/ZsQVi8tn9y9PFANcEJGbX1WLKhjGxfgjWFwwfvC5y+NL1O/XUPNMHTMpkPxcu3CyU3NQBtByVQS9UFrDLRizljLDkR15zimmX1Mlkak01bZeCqvs+UQyg5NBpJMEv9JALq1vkeOFUFek66c9WaHuTKmnzzoYOC570N90riuw4r0jRgPWlPeLVzcvgb2NVKBRzKg/pYXHyxLu3uAt30S5BfmdgbHL2OuoitTlfaUw4eBpWKF/yVk69mJf5oHXjVBvdudmHbs7CJv+fHuujACBkzEJmgNWyhJ9K0NT7IrmTSZIA1T16lw1+Cc1mBjmzhqNfNSNd7wUjN7HEIYqrFwf0gzIHCPTfQQCQFk1pf1LEUCv9+e1Up533kZng21tSzgWhQzvJV+Em6QkgCsHRrX+W7pwEuzyHnTx4tUdIbsBeSBo2+p2Jyeq4GT35SLCiJUbSDOTxyjHluzBtZgzyGb/Da5BOZbn7ZQzCeJPaTGeFX3A/svosjzawfrNOuLaR3iZ5/bMQHSb2phoOkEup8pnlEgp1jfc9jtgAV14xE6kAKjLIRAYv5L/JTAUE6aHe3KDoq2DxYbsJWLfbj9mv8JGaM6jtnXwC6p3NLup4W7dcoVgo9hZUFWunCqCFwzotjlBoj4cPla69FndfyCNuD+LRtbA3nsXe8L6oHM2LJKd4HRDxWZoDJ6iMbJPjntCKabcFw8SI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(47076005)(356005)(16526019)(7636003)(40480700001)(6666004)(54906003)(34020700004)(36756003)(8676002)(8936002)(26005)(1076003)(82740400003)(41300700001)(2906002)(36860700001)(186003)(5660300002)(336012)(426003)(83380400001)(2616005)(316002)(107886003)(4326008)(70206006)(70586007)(40460700003)(478600001)(82310400005)(110136005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 14:54:58.7673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b633cf-b6f3-4762-be3a-08db427860bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
Subject: [virtio-dev] [PATCH v3 1/2] transport-pci: Improve config msix vector description

config_msix_vector is the register that holds the MSI-X vector number
for receiving configuration change related interrupts.

It is not "for MSI-X".

Hence, replace the confusing text with appropriate one.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v2->v3:
- rewrite
v1->v2:
- rewrote to indicate MSI-X table entry index
v0->v1:
- added 'here'
- dropped 'receiving'
---
 transport-pci.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 5d98467..396bef7 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -343,7 +343,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         Driver Feature Bits selected by \field{driver_feature_select}.
 
 \item[\field{config_msix_vector}]
-        The driver sets the Configuration Vector for MSI-X.
+        Set by the driver to the MSI-X vector for configuration change notifications.
 
 \item[\field{num_queues}]
         The device specifies the maximum number of virtqueues supported here.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

