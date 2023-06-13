Return-Path: <virtio-dev-return-12944-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFB0EB64D0
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 17:31:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E2FE74437F
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 17:30:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFE2D98665E
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 17:30:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C24A6986580; Tue, 13 Jun 2023 17:30:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD20C986603;
	Tue, 13 Jun 2023 17:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIoZQRl4n26dqm6sAKnEnWKYXdW67M0qfOyUau3Cxa2l0pWS88j6TcWaMOnWlMktVBY/X7k+dJQ3C6ZYDitGsMbNPbislnNdIdnYqwxkpcJziK4uhHAtARpNPCNNVye0IvtipC5TjdqayVyHdq0azpVLB9jwjsSxT2XIqAd+zt3pobyXiGvnUyiMjo0VlePgL5GOyPzNWx0Su1SYHQnLSDA8bGDHJ/C8gvN5ch8MAu0QwXVf4Nax3fXvwLH/nEePo18o0ZTPNHzvEv5Q8++WQW8qbe4AN6z3D8pbnxZh5UeQuVPmHT5EcDzoIp1rVfhevPRQFZCL6LYOBwUEmX+lCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpnhhKY+AZMWGOlUxfddk+CfiwFN+mL4rsv45y7CulA=;
 b=R/iDaMDvHfH/NxhQAbfzDMLFaKzta6EMYUjKu/m8gMmIstvhQSE3hAmBrWHmn7hByq/r6M9fhWPSXjcuxGhVX6k/Y8Tzz/AZdV5Fby/s6s1JfMjUg3gK4Fm1+MO+SdMj+gTAwvwqQcw9vE+sLkKkZVP6Q659Q2Dmm4Ql3gROjh7y26uS1HWblG/uMYPGG6rEW6yyaF48328jycsOpJ4lN2KHCa7I7jXx2lpiiUtu/xQ0dFmDPVxHzvm+7sa4EgMYsuxMnAqQIr4Mf1x+TFYDieYbPOJS+4fSOdFkNF517kgjDsEcRoVrApTSR9xsZc9do9fz8xVAnKOABuSBXzLt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Tue, 13 Jun 2023 20:30:12 +0300
Message-ID: <20230613173015.1244486-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230613173015.1244486-1-parav@nvidia.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 796cb6be-354d-4715-4456-08db6c33ea19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xGnLHxytoNSZ+pUBf9wx+JTag0xY4kaIbhrfXc+w5FDGUiukPpH1VVkdldl0CN292ZBj+iA0Ba8c087Dv7PktYHQ1a5LjNUVyIaR9WnfX04J8PsSndnfbOoaSD7sxFMmVZADdqlVJuOWh3Wx+MvXcfInL8dhMHw6ibTm/tVNFxUoaIs2xYGWkZ1xsG/PdpZkEcnLenUQdJBPP+solILP6vCtM+Dz2GKv0YQfg2WTYjyQj/dTI/FTHRrPFwQR2vaSs/Cj0L9SgWzD/K/+22kGcpvEGk1y28sJrx1cqUKuPJd/sv9xhZlU8WR29SIi1yJRz5obXQAr0UVW38x7aEyDtFkuL7Q8dIhQyaLQP7nugm/uRqIu+w11cE3iIjZy/Cy/98PbfhuQvWrdUWtjXJs49AW52v6m2pX9BaUMZHRe1rq0xLx4BooZH8oikNQy3RALmcJVlOh3pJZycDpA/FowwceTVU5MwTYc9UxfekyViKJ45omONf4D4aZU7kZx+H12qp9gMx959JuaarK510hOcT9oqBrFDPjtH70Uv+LHV7TKeh4y81AJ16xAUJJNtMyNPdQgTvPYgGUiQBoqra3oTV0x1cylKACn38IAJXb34R/Eq1nLjq/fyqn+zGkmri2QHc4n7OQesSPDd+KGF53sn+MRiqQ5bpPJIPtbclre/6fgmaqmGCwirFop1Fe2VLAxH5m/omVl3jcwVVBZ0xhFIPgox2QzktF/ro0jePc7Dz6zNxL6agDN6m6vrbD2XwQ+
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(36756003)(86362001)(82310400005)(2906002)(4744005)(40480700001)(2616005)(107886003)(336012)(186003)(16526019)(36860700001)(83380400001)(47076005)(26005)(426003)(1076003)(356005)(6666004)(40460700003)(110136005)(54906003)(4326008)(478600001)(316002)(70586007)(7636003)(82740400003)(5660300002)(70206006)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 17:30:42.8776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 796cb6be-354d-4715-4456-08db6c33ea19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
Subject: [virtio-dev] [PATCH v6 1/4] admin: Split opcode table rows with a line

Currently all opcode appears to be in a single row.
Separate them with a line similar to other tables.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- new patch
---
 admin.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/admin.tex b/admin.tex
index 2efd4d7..e51f9e6 100644
--- a/admin.tex
+++ b/admin.tex
@@ -114,7 +114,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 opcode & Name & Command Description \\
 \hline \hline
 0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
+\hline
 0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
+\hline
 0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

