Return-Path: <virtio-dev-return-12533-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CABC77B75
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B60E415B68E
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AAB9C9866E1
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9D8AB986640; Thu,  4 May 2023 02:30:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08E7E9866B5;
	Thu,  4 May 2023 02:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUoihjkGhyor778lwg+nNzZsooz/Hkn8PuZJyJgr4v+6yAywhHs+cdEKREB5NevGo56rv+2wCVNYkOFvRKR3p8BhAsUToEmTCxn52JDcQXJOiKz4+1gAmHVL8lP+exRvV0X732oDMyz1NGUwyx/0kEXeawrrikpgEq9hJBToa7Sywx2/aa5429KxCaaYOQiYShMSqTDja+rCKZVzVyMg3qhqxbN0tZoL8ruK/Z23fFSKC0zUUI9Y6Eh04dC+EPQAlUO2v72MV9uQyRjCokndJc0djTaKR5buSsUoCendlUvRSNSJtYDxUCkgBle2nJAJOD8emRd7LjSzm6oLHRbudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w45FPNdKXUDd/d7iY2wkceZlPvjwO6VW46LY+j8PioI=;
 b=iS8SenT54rAjVE4bhWFdsN1/5aQqejLaHPjKRHcpz6FF2n0NSQr7sRcW5eQBLXJFKCStZol2ACq9qg8e1b5Dasia7x0ZHQ7C3+ArYjAbe/Ru/qZYnRhC33DIc4JnNcw4RnEWbgNFIBlHQy+oeiXy3nP8Uk3MQ9502fKllAmfE+W/wLObmGCsVm2704+Vm0cSzSuygkNI/CAK+kMyFnoEn4Yw2MWxqK58Jp+9cyeWYzNygiNW4W/Ef4FwHzdmuNDqTX69WohmiPqwfjuvSqGuQGjRyMxdxw/88LJMYg7R2WgIZBQ1BuEL+LsVG91aj5C/MrbIev4FQNL35LyU8euvIA==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 4 May 2023 05:29:49 +0300
Message-ID: <20230504022959.547025-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230504022959.547025-1-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 307b5c75-f6f3-42e2-b025-08db4c4787c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vPlBvmSTRT9UHkixdThISEGJLzrhxTaSED5Vgn1DWdNB0NOtTB9SxA+5TJQREweII2lA7G4Enp66rgZa4sq9ODSVy9AA/D2fdT2HbcwsaCofq70GR7o3wUygoY3P7CXMGVN46YApF7BtnY9dEQpFpYbXRziHSSdwH3c7he7SwD3C70ou01Sy0sDlHjxK68gKZJ/1tmiR3S0wtM+YssSF/s7PA+UUhN/+VP9z4m9j88i5RHy6FEo140OU7Q2ueC9oX0TMrKF7RPF8H3+k7nx1a3pwezMa27ONk4UcBoiGK1kbJvvfZ1pGnO6yETPStr5kLlQOt1vKgMaR68jpyuBMAirGsVI0K+qsH4X+NUfBgVQu/BMxFJVhOa8+DoIPmwPl1Eu9EMCu3iqlc98DikJ5eBIrvN8HfIM91R8PW26GieIqBwHtUMrOUcUK3rm08T0p+rBODa2366NiohGnvXd1mDWt/Bk/v8HeJHoWttKtr90k8RL/ah/BLu17YqAUiucPsZaHzFTGpEgd5HTVx/9NpkhhkbAd63WidQ/Pr553CPdrPdKd0Rd4lbqyat/BdQFGZz2Ytec0CetDWUqvTfvxmZ7Ho4xH/QaVX2m81eSctHJOE1s1fOWzpWzOFSuspyHKbcQL3jp3kziGQSkAqIvpVhymVyk/3d9D5aZ+xyr3RbmdieB4uwnme4phgTQRltBn5t2HgvNLEPEMyAH587r6O3z4fSoQ8LjZEg1X6txsyITnJHfALpXX0oAS6vFYlDlm
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(70206006)(2906002)(5660300002)(36756003)(40460700003)(8676002)(8936002)(41300700001)(82310400005)(70586007)(478600001)(110136005)(966005)(4326008)(40480700001)(316002)(86362001)(6666004)(54906003)(107886003)(7636003)(356005)(16526019)(47076005)(82740400003)(36860700001)(2616005)(336012)(83380400001)(186003)(426003)(1076003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:30.5592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307b5c75-f6f3-42e2-b025-08db4c4787c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
Subject: [virtio-dev] [PATCH v16 01/11] content: Add vq index text

Introduce vq index and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v15->v16:
- rewrote for better reading
v12->v13:
- avoid virtqueue -> vq abbreviation
- removed Cornelia's reviewed-by due to vq abbreviation change
v11->v12:
- renamed 'number' to 'index'
v9->v10:
- added braces around vq number wording
- added vqn as another term for vq number
v8->v9:
- added inclusive when describing the vq number range
- skipped comment to put virtqueue number wording first because we
  prefer to use shorter vq number as much as possible
v5->v6:
- moved description close to introduction, it was in middle of
  queue data transfer description
v2->v3:
- new patch
---
 content.tex | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..9b694f2 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,10 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+A virtio device can have maximum of 65536 virtqueues. Each virtqueue is
+identified by a virtqueue index. A virtqueue index has a value in the
+range of 0 to 65535.
+
 Driver makes requests available to device by adding
 an available buffer to the queue, i.e., adding a buffer
 describing the request to a virtqueue, and optionally triggering
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

