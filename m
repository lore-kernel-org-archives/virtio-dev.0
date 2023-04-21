Return-Path: <virtio-dev-return-12343-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4614DC77B71
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:55:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A10FF41EF6
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:55:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 937BF986667
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:55:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8407F98663C; Fri, 21 Apr 2023 14:55:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E6EB98667E;
	Fri, 21 Apr 2023 14:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkisskTZgeqUrQQR6HjpGxPbrq1kNmMP1dfezDm8sxFnASdiRY83rEgW9kT6qBMRrWhMsG/LNdgwItm+OF56YA9Y4H6t1hRg3Poz7c4Du0q8Y/3REfhm4/kRTzWO7zrqsz7QnFVZx67VBnqDCIsdH51v91wtgce2emA4OB/FuTC7+nWEhjmiDZF3OQs3gZWk7HfHj6eBXk9MMSnzl68YjdmV7aZSsEhBLDiYAXTergwKlfLG64f8xcHeQUb2T6txdb3M0KM1JhKQhHOhoUJQ3Kix9CMfC4jaFYohz+y0GmR2pYHOngWkHvfB1v3c2xnDyAGZ6ebKGUXDzTepsxOoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPTxxsgghW76xWjeSCupcqMfsuEK3dhgTbH/Cl9OoAY=;
 b=UDQWpUyyiuli1I8sddyu+1FlPRAWuZqewrX/xx1LuWhxhcIbC7+EA8iVpoVSMaewMCipWHZG7tB72lDCVinH0tN1+EukCeECoDp6shE9q7ItdItfomo2rdwq9zBAI+4l0UeSVAOo6g5oYq+HBgeoNE99b+oUNCFWfNZi2fAMeyEQ+sy06cRTngEl+cECX6hKHZ48P1bOQIbIiufasFhmgdhVrJZgTBcf2XRlS3/NgVjWQE8IOYunKfrQFBw05NeHa601rOXB5W5X+3X0S6ZvPEeRMp/Q0dCcXPtAIgwX0YhNUzsfCfLf9SE5o2+++O2o8mx7HbieHNch8vicUh2u6g==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Fri, 21 Apr 2023 17:54:34 +0300
Message-ID: <20230421145434.83774-3-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: a983d547-6e8f-42bc-74e2-08db42785e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+V82DtTAw8Bk6g9I501TfZtnix7AieSNC9onO97wRMAuO+wLcpuNr4lpzKyVTddb7d/i6ovqQQB/nXOdbuisUfbSwHM3m7cU917cpRAyjYPY8hMxypPMdULw39m35b8egXsRj+eT1N9n6CL8VVTF/tvbH6/NDjqfnI3DILCCVSMnS5i2D2IEYfsrTpRWepKuafNrJWIGrKwnMaRmPmMT9v8uQ9glG9YXlVRwh37eMTFk+8kI/s4oNMuEif7783DrqQD3H2ds2rnii6GCDoF2+EhwH+bThIXAYGYcA5Rsbd96P/i/VVlzOqzxDz1II2ya7f/CZfarh2f6pfrGnO2cfn4lYwPO885dVlTu29zwv2SgJ6f4B1QXw12ejRLf0qKQPPmoXDE3v+9RqlHxPsS3ePgC9zMQvJdJTb5bhERqAsB8t4ffuWgVSfNLNOv2ZPyrcXxn3ZKhBIZy0pVCMGKAEI7LAhHGbWCjYDR1U5X33qfAlicesDXVGoa6H38I+OcLQXIeX4zD8Q6hMpE4NQ4TUuAQxZRaT8PkNcZFefewRB9i/5tphx2wZRzhfgPVAS4HQBHJX2SfPfIo5SJTZn83GmR0+k/6NMTPJyW55F6EEtdZ7q8AVDhz45gEm3zD7ankTKVLvZlPuUh8hOkeH64BWrmpqUJ2nBZRRXuku/wjs/dL/IGvTu5Gi+LQo90UI9LRa5OSnIhSOa4DP9D82TkbFPCaWfs704qJ1p1VEI/bgUfKX2ZXpU2A+hvYLO8CTK2GibdaqAYfYwJYEL9xSZVJ5IYNanu25KcuNkAYMnp26qg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(4326008)(70206006)(54906003)(110136005)(316002)(70586007)(478600001)(6666004)(40480700001)(82310400005)(8936002)(41300700001)(8676002)(5660300002)(2906002)(7636003)(356005)(34020700004)(86362001)(82740400003)(36756003)(2616005)(426003)(336012)(16526019)(26005)(40460700003)(1076003)(36860700001)(186003)(107886003)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 14:54:55.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a983d547-6e8f-42bc-74e2-08db42785e86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
Subject: [virtio-dev] [PATCH v3 2/2] transport-pci: Improve queue msix vector register desc

queue_msix_vector register is for receiving virtqueue notification
interrupts from the device for the virtqueue.

"for MSI-X" is confusing term.

Also it is the register that driver "writes" to, similar to
many other registers such as queue_desc, queue_driver etc.

Hence, replace the verb from use to write.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
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
index 396bef7..524bfff 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -366,7 +366,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         A 0 means the queue is unavailable.
 
 \item[\field{queue_msix_vector}]
-        The driver uses this to specify the queue vector for MSI-X.
+        Set by the driver to the MSI-X vector for virtqueue notifications.
 
 \item[\field{queue_enable}]
         The driver uses this to selectively prevent the device from executing requests from this virtqueue.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

