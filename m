Return-Path: <virtio-dev-return-11762-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30828C7619A
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 55C3B2CAD1
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C8909864C6
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3F4A298646A; Fri, 24 Mar 2023 01:36:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2BEE998638E;
	Fri, 24 Mar 2023 01:36:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYrEfqLIMkDRjbljruuviifKbO+0y/s93KZNksgHWv4f2WGQ+raBWkxkVuf007Iy0eJ6vmjJ23f6j53sCdnhhkZ6JCYJ/3kbBCLJtq0ky1a6b0ZYyEBLmR7ASSVFRcafYSBMu+TyxfOIFfBWqcrcNBqgVtu+vK9Rr6RLTbnSouJCbKk25J37W8wFxW9p5lKC71xlvWWZii9YWudZoI+FoMFv1I3To4e+dOjmw8wW6TIDCDSl7gUyuVoIXofaweMcdYFxFC3EDe2/77OfRK94Q0/5z1GVrvoJO6I8PIQEOfEha46vuxv8ctNxYz1UHo0FFpyIXJ8cZU04p3Gnl7Nk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3gUZa6s/Y9PmYFHx97Cn5nVT2OUN/SE8PUEERmA2iA=;
 b=eRsxfeqrW4CGrE/+Ut9ZUw+o2Zo2AOekZaxsJAHIwOvae2qzo6aD8rRd+vzQnXZrHIwc8HwvLE7RwiolrNz1OBfTwGK8W6ZTzr9i6J59o7g7KalBwI99sbsMD5bnUdLqKmB7gU4LcvzvixmgbstjDkWogHzi0nz5dXPcqPNw0Iwnw4fYPcHfRcFHaROBFBh24jabgfsKCFHvkfzcwJbhDkVSfWQK//eJecplpCVvGlAOXU4P6oJmTRQfUpN2JLb29I72NVJtXo2zjdkh3d4MGrjzpXcbkQ8//KtsKlwBeFj9LTXJtUSDyHAIO7S0a0laAVrbJscXovhHafelY3tmPg==
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
	<parav@nvidia.com>
Date: Fri, 24 Mar 2023 04:35:32 +0300
Message-ID: <20230324013534.280820-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230324013534.280820-1-parav@nvidia.com>
References: <20230324013534.280820-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 925d2051-bad1-455a-e1a3-08db2c081e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/JKt52BJrXU3JqxiS+3o9s0b0+3U8M8r4K1kDvDaNzkkUIE2dEYM790l5CvBVfblFdZZJMGovggVdtMFSToWzVuIRSBFwdvOIlHYImE0Vv1RtyE4Gh9BZQ6ukuO0rouk78MuVpbMW7ztx+zL5lugWWbNUM5zO4YoZP1zS/JOM1A3yTyxAAr8Jn8y2OmCX/tNVUkH1uZiHtCsxsAneF+tHnbGjP6LyK4UPBXisbAOn//xQYBw+uJ6nmh3RTq7rdJZ0dO6pM7dZQpAV88xsF0tzJqH3dMMBni2UzbA3T+Ne2nRQWn9MPfGIyxyXciQztUUbeyX/ySKxMgJt1fm7WP8liCqFOmVT0AbuPX7q2CLum4T+XB+s0WkMLM0qGDlxkp/S3GOjDx/sLObicASxsZEtNPB4GCVL/ZKq4fxrY+nnOYYoQrkhJSkcbthxI4HiOyZeC886hlICS6FN/YDPT0GMATHY1E2K4jIbGGJI0DGrOX0lJVdzv1CO1DhkzmkJB6IRn6Xif0yS27+UGwD8kvyu+Ryq2n+oBOCu60GlVWUn1qPyFOSoaO5A33/6VTsonz5ed2SgPY+V7wLLPGF+TFs5qhW61+elYUwW/OZvecrNB6myt+9x9Uy7lwyrSsRo2UZRTXn4iuDrXrCAtaV233cqpCBzXYc0IkDhifZRUv2IdlX1F9xzK9ABVIM/S3SA13kTTD1aMZ2H6Y+zDUVbH1Z6sKiNFBq6w5fs9gXHdSSCUF/tMJvxt4ELlpSelXnAxHw
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(46966006)(40470700004)(36840700001)(8936002)(70206006)(70586007)(41300700001)(4326008)(8676002)(86362001)(40460700003)(36756003)(7636003)(1076003)(16526019)(356005)(40480700001)(26005)(336012)(47076005)(2616005)(426003)(186003)(83380400001)(6666004)(107886003)(82310400005)(36860700001)(316002)(478600001)(54906003)(110136005)(82740400003)(2906002)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:35:57.7464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925d2051-bad1-455a-e1a3-08db2c081e1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
Subject: [virtio-dev] [PATCH 1/3] transport-pci: Remove empty line at end of file

Remove empty line at end of file.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 1 -
 1 file changed, 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 044c085..6e0cb45 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1148,4 +1148,3 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
         re-examine the configuration space to see what changed.
     \end{itemize}
 \end{itemize}
-
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

