Return-Path: <virtio-dev-return-13943-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21028CE7A94
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 11:18:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5D5272B03A
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 11:18:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FBA39863EF
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 11:18:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 27081986379; Mon, 25 Sep 2023 11:18:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16DA798637A
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Sep 2023 11:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEvSIg7uCk4SH3mVVVP8YfYggjbPGWObzIONgnsd5FVD1H9B2fncDHZtdyXlWucTDRpyWSv9vnRybWxMzW5hMp1MVtqdwZXjMMHDKLTltrCOb36CqdS/UkUKziFvCyiaJ3bAJIu4ZQ6FdQg9ZYh8Zz1eAgckh9BXbAbxY03TkXMxR/+j8YGMICYaoTPDqvXGYu7E7/Siiu6weThh1d5GXI3A2NPLF2eWwb3zCt5PZXsxwqI4XyGaddbARSVMXffRvp2GsvojICzVYFqXttAsdI8cSjFrQyYnVY0tSkLI/Pryp5w8d2zTHOYBSlGJf0sdllKNpJxR2hXxre5dNlyXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++YE/jafxDn357RtXaqUqiWDbmb1DlPGz5PNytYs24o=;
 b=YfjnQAwdz+6aegvz9GaIjLx9klV+32fYzD7b51bl5GN5/bYVy027WDOgU9gOmgPQVQ8YfscXK0eVl3Xgbl/H2mrPV9OWzMlB37Dh69EOBb/kBkDuPX81Bhtg/Y4SEQHJzudj67+7dHuOQHLgJnE4Mg5RtAFUh4scDd8Y26Grca6pfu59ASZrnwHq/gPXFzzt51tFngu8lYrp4CwJZhKwVa8/PpKNByuqobWio83DdnsbJmYEqJfDqF3bIt6hVQ3TdZTY3IzSZscJr4HoCHbhuXJk38myf9TbJtOd8mu/MQMGT+Wp5/xiP5OiY4IayqZNj7x5ZCsAlC5m3TjeN3pLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.oasis-open.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
From: jeshwank <JESHWANTHKUMAR.NK@amd.com>
To: <virtio-dev@lists.oasis-open.org>
CC: jeshwank <JESHWANTHKUMAR.NK@amd.com>, <Mythri.Pandeshwarakrishna@amd.com>,
	<Devaraj.Rangasamy@amd.com>, <jeshwanthkumar.nk@amd.com>,
	<Rijo-john.Thomas@amd.com>, <Nimesh.Easow@amd.com>, <babulu.ellune@amd.com>
Date: Mon, 25 Sep 2023 16:47:09 +0530
Message-ID: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f46b426-5dfc-4649-13ba-08dbbdb910c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wtoX1ij5h8DOgdFEQgOhh/OHwlEyNN+hLFfYxO3TuIfibBZY6EFNhjYaF9av83PY/qEGTapJQlMGQaqxer3tvqolud8qMDiMRLIi5+DQ3Pb+q0P1kYTpE2lB66BHZ97Ic1u6nqmH2blemtr6AiMtPBLqMg+Mj0A65YxqaEkRIi2ix5HhDH8R2lGVBYUk5FQdAwrLOv+l58Jk9XBQM+Q/0vbSS7/ppFqZ7MW+h/OXsANGOQFUB27d0tsl/85Q0ClnjAzMgV+hgW5kSD1MCPmrjGtf1S4PAILEnOPATTwIGAJDtECT9crjV0Wbf8b68h8k+nDnexuoFQgIjfjZlXbDcRXpaF2wAgBSdlq9j/+nixkhSo+1qpd8X0YiHJpZbfG9EokyxXYiLbkMVMKMvPYDZbd0eOCNnU6m0aaHDmtTOzb2dcW87yvjn/F43jfTQGJTYwkAnrLpKhU7ejg+TUFjHmNnMTqLCkBCNclQrjZ8FhpVcCvMdsvcwW79Rz0v2Rf4lJr7eNIBvkBvm2tBzFI70nHP7KFS18rDl3Y9G7fjgXCAkGUxu7IWa6/BPq1GoTGZBGhLzD1RShVLLpfJnN9lfPuNmGB5bQDppnZpK8xxGlKLzguJkZ8L6HC3DNmMsKRHn0aa0OEbsqAFeGmJwbWhNHs5qR7L5cmlYRyXYaNwJJoiQ8E+OYYDPnm9h5fSUnk/j2Sm7RClSUU0Gwq3K1XubzU47B5vluXGDLj8k2wJROR7VLS9K8xUDYnQzaNTMnuzZIWJw06fzWo0TNE+GwjTceJZooy1HuBGQ1MnUYDKfr8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(8676002)(478600001)(41300700001)(40480700001)(8936002)(83380400001)(5660300002)(6666004)(54906003)(2906002)(316002)(7696005)(6916009)(4326008)(70586007)(70206006)(36756003)(16526019)(26005)(40460700003)(2616005)(336012)(426003)(81166007)(47076005)(82740400003)(356005)(36860700001)(86362001)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 11:17:55.0120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f46b426-5dfc-4649-13ba-08dbbdb910c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
Subject: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE device

In a virtual environment, an application running in guest VM may want
to delegate security sensitive tasks to a Trusted Application (TA)
running within a Trusted Execution Environment (TEE). A TEE is a trusted
OS running in some secure environment, for example, TrustZone on ARM
CPUs, or a separate secure co-processor etc.

A virtual TEE device emulates a TEE within a guest VM. Such a virtual
TEE device supports multiple operations such as:

VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
                             TEE device.
VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
                              TEE device.
VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
                              trusted application running in TEE.
VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
                               with trusted application running in TEE.
VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
                             application running in TEE.
VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.

We would like to reserve device ID 46 for Virtio-TEE device.

Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 0a62dce..644aa4a 100644
--- a/content.tex
+++ b/content.tex
@@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 45         &   SPI master \\
 \hline
+46         &   TEE device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
-- 
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

