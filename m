Return-Path: <virtio-dev-return-13360-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659AFEB64DD
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:25:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 484C1120D58
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:25:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E39F986846
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:25:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2FB4B9867B3; Wed, 12 Jul 2023 22:25:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7641C986839;
	Wed, 12 Jul 2023 22:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI8SKso77ShmuxJKfaG6wEJFkenzvwBAyvS/legycmcYnINdzVYpNBaKPaAwnTsjyw/PUs2ENdTYJMKO0wXTuwJAAfz6beKtIvcGxTSa33nQ6lKit92fgnKdJwCT5EUZsqN+j+5BJuFpvmK3TpTTaRsOYfe7B43/NhJ1eipC3zYj1WLps5nXJ27fV3amQpkvzPDFbVetmiOhIJpWvF9cWU9/9QJBd1Kmw2hEj74GGoArn8wPdleZytOTAB+7FhW1BloKUy8OaIb3h1BT4S/fL+VDvELyrZ0kgFL8t0+32qWOXyWkexQCZmiVZlMLi3H5FwwplLsOvj22N0j2NFp3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8bjPuEKEvNP68wKPn+1fNozYDVP5qMGyD0F6ngo81Y=;
 b=F+dMnbbMcJYDBZz7S2/KdCTUeYdqr/EuM21ceiSaZmRaoKQ7bkAV/QpM7Qq/nc53/NZk08QUJi6r252vNFMSq/IDgJM+Te0+N3XGY3u8xjJrjbtZg8E5BFZcsdqZ63VwJe6wE2hrHa+e/AqbUxBFUEXb35cQ+yqF8M4nB0SpHVBmNq0/Q98UAFX4ipguqkszG6ZLWZ6WOvNBaqIozpV6EpRNXZTuLsGBo9NbP2ENgduK2N4SnM7zOpWS6tvDxkttMp+SdizYY6ulQeWcBkxq2Ikac33x1r3QmqgTOUQvLYkZwPxQXsfrp15xQPfiStJmT3OOCvNrYt3zqCvQd00OpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>
CC: <virtio-dev@lists.oasis-open.org>, <hengqi@linux.alibaba.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 13 Jul 2023 01:24:05 +0300
Message-ID: <20230712222405.455201-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230712222405.455201-1-parav@nvidia.com>
References: <20230712222405.455201-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c8ae1a-358f-4c8d-d025-08db8326ca24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	57QsOO+wLVdONNP+9wSiAhivLHFzRIhYO6bN9WScVXobO3FTD2Maf6RfZD1I9WXIX4N/uBKsRGwiXVnBOm4MjbPbK3AQpBediHROhZ3ysjQLf2BQQOkCm8q8y6BnmOtubPQxNhxo3s2DpvSaq1XFs5Xq3g0zIFDbeUV96ad5wr6/TrpQLMb6oPgm9NCst5n3yH+NZyFQS1mPB7IVxfuAsKGtgGfIevP9JaeyAmGGDWcfa4ZU7jVQUEb7zt4OW+/LVhezXsNjuM3wnV8ImTT57WOFj5043SLn6TBmU0JUqxIb6MOdnSFyHvzzEyJQxvJuS8Kvsq17xcBeU6gam/UWJNS4XOCp2kIw5nrfXGhqjhnbXnxkIGZR8RmP6TXr3ul2FTY9BAMO3o6YBb4iIH9Kw2sLAk/GfUChK020r7alfp2gMjrNx/YOy9ZZ8c96SHlgn47GTXPAzUAN9K/gpypj1SdZFwflutd7PlJdrKEpYoUcx8Nakvr7SUa11UnH+qn4abk+RBgmo2pAf//kIjDJ7kAumr0/JuBsCFit9aQttNa7bFAhipalgTG4TxRB5MRmHvRu5EIgQWlOm0/SrxwYQEeLk+GXIbrCzweaFyYMKP8fVSvMytbAQ0YC0wZoMSpu5ZCErGZYjLLS8IGzjeMLQOThWlrwOAmNKaNrh2tlB24CEojE/Rg0J549rYBJ/9eUBigGCRhvT/1JvoDLex4sgFHKmt776ClVffrF3XPGt5mq5QlY24+dByhs45MLLRdb
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(86362001)(40460700003)(107886003)(82310400005)(8676002)(8936002)(186003)(16526019)(36860700001)(426003)(336012)(47076005)(2616005)(2906002)(36756003)(5660300002)(26005)(40480700001)(356005)(7636003)(82740400003)(110136005)(54906003)(6666004)(70586007)(70206006)(4326008)(478600001)(1076003)(41300700001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 22:24:42.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c8ae1a-358f-4c8d-d025-08db8326ca24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
Subject: [virtio-dev] [PATCH 4/4] virtio-net: Use note instead of advice

Section like "Advice" is not the current practice. Lets capture such
advice as notes.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 68311ab..a8dff97 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1090,7 +1090,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 \hline
 \end{tabular}
 
-\subparagraph{Advice}
+\begin{note}
 Example uses of the inner header hash:
 \begin{itemize}
 \item Legacy tunneling protocols, lacking the outer header entropy, can use RSS with the inner header hash to
@@ -1105,6 +1105,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 Besides disabling the inner header hash, mitigations would depend on how the hash is used. When the hash
 use is limited to the RSS queue selection, the inner header hash may have quality of service (QoS) limitations.
 
+\end{note}
+
 \devicenormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
 
 If the (outer) header of the received packet does not match any encapsulation types enabled
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

