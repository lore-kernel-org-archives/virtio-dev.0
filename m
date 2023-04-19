Return-Path: <virtio-dev-return-12292-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB71C6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D3A0587CC2
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1CB15986635
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B5A28986681; Wed, 19 Apr 2023 01:47:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE1C9986646;
	Wed, 19 Apr 2023 01:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCx93ZlcV3HLUAFZfqO3/AgPKEpVkLp9/mvEwfv8lEdv9sDv7V3grN0PU8OWv0uWSLFgEVSNQ18nNRrJKs+dYr5/f8mVa7Sr1Dw/t2iPDnvp6BMgoW6KWqiKig6xwUl6SyjLg1+OSHC08w7peZfxt+u13hp5v4SnwOFZIFXoX0Y5WMdly3f5I+wu2OD3aa2zoDYEq26bPjgISWh8WE+dkRXxCcGcEWGNrCrhmJq364WvPiWqU+iKrvPxzOTLZAVgB8GbrtULC8KojrvxeP4xsHAtj2NULY2GFmJShe7aHQnw926tFXJAt5zb04MU1yQZKH/zDibtArFK0yBDqX6PZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP9IUJAKeH21fFHEJgpfHaE1XCRr3CK1uy2uecOEr7M=;
 b=aUgsVVGXQkEImAI7FvROeWHGFp34zOvMNamhbnf+iqKgCo0wui5lqXBJV7H8dxyrqPBVG8nuhUHxFVdKv8esnwSYfeBQSpUyHfYa7mE0CxG8Ipm89JUdRaAGhJaXsETCt/sUYNko/aZbvMjU3mUv/fHmHD1Ps/lQ6vnaA6EkFUdOb6mifHE5B2RGjRcs6fY3clj06OdIz6K6VGvCGxpBykfG3rRYYTVMCBqxJWCeLd3DKp99NfO2IB0lRNbH4IxXbnNLZ7WgRInVs1OTpXk56Jrn5idl+p7zRgZe4Pyq8m53iWbTALpCr3oMmeazXAMNg0Rl/Vf9ZHeWdrDKZDXkIg==
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
Date: Wed, 19 Apr 2023 04:46:32 +0300
Message-ID: <20230419014639.919458-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230419014639.919458-1-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 71acc934-088d-458d-b5f4-08db4077fd64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bLsW5A+XCSLNRDhxdWRBONQQqrwGck5wQGevWx49XyAX1Jp0ckDlFTQE3hI9PmEXUJ9GnF2Azw92Wxs/7QDVBIlEcGyxBLiuiYtwGL1P1BHdKOneQuO49Wwj7Fsj7qotT7Xm2Dv+NgLJoRS4bikxog6bnLIOZpX+hgTP0OnjUjzghH5OMHQEpKpJf114s+6phV0N8ac02NPU5xCtt/jd8etfZQGUL03NR5qbZf0aXnEhYC2yMNb2ALW8PV/BWAcd9ZVuG1V2XUMcOLEc3DJ3++UIcOaHOpnVLXs/1mNDbTwa6HqFe/owhznziUAEaM3FYCZESjyqGbBtPx59VLA75UtQcu5rUkzE/wXWu3BvzNBRyxwT2asCpaW0dWg9oXLvd07SgkbsAUpRD0O9QHA2fjJhwGWEYOOzxhxgxWvQg8cDwXFF9uLkTVnIIfRlXmM2ksLMsrQDIQLzJc3GNYOsMvC0RFkHOI7q2ztlrrqNcHMKNj5kFW6oEuLBAbI+lLxG4VpKhpzHTW4PWgDAmlYp4/uq05mjJAavvezQcbBJAlcX2kOE7Wap4s24J2rCAPquHzaXOWL2+ErKhiRDTMxuIVoGu1S9KVQgxeEAleqz5+pKaJY/5SpvE4maWRo255tOdvcRi1mjuTvWW4rDIn6fItGs7WhiXEiLwXzG4tgk5HT53Jf1hFnI3JG8E3ge3ttoLkawFRJgHsZ6TjLfq41k6/MpHB4alVlmyp3zWQKbbYupxg1EyW+vjCV/bG6bCCgU7EvjPFX8F1xXRV2w3oXqeMZeby1W4qs+RAaHzPJZz3w=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(86362001)(336012)(426003)(26005)(1076003)(36756003)(83380400001)(82310400005)(2616005)(47076005)(186003)(40460700003)(2906002)(107886003)(16526019)(36860700001)(5660300002)(966005)(6666004)(8936002)(8676002)(478600001)(7636003)(54906003)(356005)(110136005)(41300700001)(82740400003)(316002)(70206006)(40480700001)(70586007)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:47:09.7391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71acc934-088d-458d-b5f4-08db4077fd64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
Subject: [virtio-dev] [PATCH v14 04/11] transport-pci: Avoid first vq index reference

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
index 04a9a80..1507c69 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1011,7 +1011,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
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

