Return-Path: <virtio-dev-return-11756-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BA2C7619A
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:06:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C823B87494
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD27398673E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C14EF986747; Fri, 24 Mar 2023 01:05:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 956AD98638E;
	Fri, 24 Mar 2023 01:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlCmu87ctYVUzCuvnM1sBCvX6TJyYCI7PhZlK88M7TKWkuXeuuRIMhNYmNdPmN/WcfEHSkCns4GIuVzaCiQIknLPMi/JAmUe2+DTQ3Ws2rKE4KqCdBxgBgqNvI9T9OI9UP30GnkXSiXMR3s6QCSRjes261fIsOFyMpj0GcJ7qLOUfnW/AcZjm+ySDtX3LP/SCtRoBkqZF/Q8zkCLyLi4RyZCzz7DEFKbUgVRDxlPg0REjWz6mCBvoWNTifg+hF6Wc5fibI1a5ExD3aQSKWD4CMAMUHVGn+VfAMC0olfSduPkIUb/YUdZLQe4bAaTaljJsnTq3KJ8+j06HRnal9DP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv/QXA9hS/AwFYlegISNQ25GEnz9PMI64eQQMoAaRuQ=;
 b=OInDRU5/h6ggciDBdlonMFRucD30l4DH36YVVzKBAkZpqBiWs7DGKf+haWhr+LOfFF5BC4lZhghCMBZCEJ1RfzN03GDNyHVDq+mc1BmWgNAHM0Uz32y4Pdr/NFkam7rfmLUCrf+g2WgHVSXeBNQbnyj5DXSw9X1ytAKESFqf0O0k72/HcnOK4yVI3BUsyHkgK0D3pa5TCGix4NQtksIre5ExUSy7jSlMcFcu41jXjAZTZQOmp+9lgejFM7rdkVrDT/srJ8WnPYjGwWZMlMMXEvUBf3+i1NlIDz/Tm1evFpwGlaNah+1AqZpLT+Srz/hPAHXL5h45tO+Qlo6TX7gGXQ==
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
Date: Fri, 24 Mar 2023 04:04:25 +0300
Message-ID: <20230324010432.280330-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230324010432.280330-1-parav@nvidia.com>
References: <20230324010432.280330-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT067:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 10587dbe-5fd7-4faa-96e3-08db2c03c871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QtrTfjiJm6NaMy30UIv5l1o0nm7302xM+vGPVgQUqQhUf+qLQ2X3FIloeN21fc0tvk6pTlken7HDP6UJ9eZQXJLWIl9xjP174O/KFyNeRJqcfuV7cUJOnuz0Z1qcb7Cda+baKx03UePgE7n8iO1yykBm5zPm2uARIB9UHeeB4X76+Hf4vmG8M+07aVPzOWcVEWR/3upDF3oNWO/4Z0GTdtx1vDSx35KH+c4V1pJkOZyb5orjSNm6lPnE7hbVf/VJKkVLKBIDKL9ZtKERt9OsBIVxHF1auDIRa3B5qlwLrvQjUS2qcX2TFIR8ZMDuPZ4EPlbYwlJF4H67jIptSY3WFzHbKkwfXL+dIB57+Uk4JAtA7DhRMxBlmgb4zn/uPNYll7eSiRSiGOrglUUi9jtjB03tsNQXVHIJSiLqoiiZ8A4JEGEVNb7zJv8ApUIQg0gZP6+8958I8FrlAMepJWBZE9sl50Lw2kw2xh98YNIaOlVGESSZWnIMj4pSW4i/ZHTnbAxtoJWFs1+qxkEBKrL5XIhZQ6OwutwtViw53hM5lV/bNb0/KNuNchlmm/uRtZzGJUfWaBwPjRHruehbutKlUS4jUKQmyff1gS/jdMVz/GrGYNK5DGbR4TXwGu8DzaHySUKKqzNcS5lE0AXs8aWUhqn1oY4inrqFgFxMlZo8EHM4ofZHOPtEeq1RDD1Xmi3RXpq7z7LEHE0nhhP6BGN7iV+IDRFKmPGGpbj/7sIqwMSfFWE0vJeeRC5tJM+6XqvLB3XEgycsax+HMM2+3Wo0mfxIYAldjxpdQKOWYZ68qX8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(8676002)(36860700001)(54906003)(4326008)(70206006)(110136005)(70586007)(41300700001)(5660300002)(82740400003)(7636003)(8936002)(316002)(426003)(47076005)(26005)(6666004)(1076003)(16526019)(186003)(478600001)(2616005)(336012)(966005)(83380400001)(107886003)(82310400005)(86362001)(40480700001)(356005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:04:56.0906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10587dbe-5fd7-4faa-96e3-08db2c03c871
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
Subject: [virtio-dev] [PATCH v6 1/8] content: Add vq number text

Introduce vq number and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v5->v6:
- moved description close to introduction, it was in middle of
  queue data transfer description
v2->v3:
- new patch
---
 content.tex | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..5171c12 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+Each virtqueue is identified by a vq number or also referred
+to as a virtqueue number; vq number range is from 0 to 65535.
+
 Driver makes requests available to device by adding
 an available buffer to the queue, i.e., adding a buffer
 describing the request to a virtqueue, and optionally triggering
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

